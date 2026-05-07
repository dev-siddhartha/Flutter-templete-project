import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_template/core/utils/logger/app_logger.dart';
import 'package:safe_device/safe_device.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
import 'package:device_info_plus/device_info_plus.dart';


// RESPONSE  — ordered least → most severe; never skip levels in logic

enum RaspResponse {
  /// Score < 30 — log only, no UX change.
  monitor,

  /// Score 30–59 — silently disable sensitive features (payment, export, etc.).
  /// Never show a warning; that tells the attacker which check fired.
  degrade,

  /// Score 60–84 — force re-authentication, clear in-memory session state.
  /// Surface as generic "session expired" — no hint about the real reason.
  invalidate,

  /// Score ≥ 85 — wipe derived keys, delete secure storage, terminate session.
  block,
}

// SIGNAL  — one detected threat event; immutable after construction
class RaspSignal {
  const RaspSignal({
    required this.source,
    required this.category,
    required this.weight,
    required this.at,
  });

  /// Unique identifier for the specific check that fired (e.g. "frida_port").
  final String source;

  /// Logical group used for cap-based scoring (e.g. "integrity").
  final String category;

  /// Raw weight before category-cap is applied (0–100 scale).
  final int weight;

  /// Wall-clock time the signal was recorded; used for the sliding window.
  final DateTime at;
}

// TRACE ENTRY  — append-only audit log (debug / incident-response use only)

class RaspTraceEntry {
  const RaspTraceEntry({
    required this.source,
    required this.event,
    required this.weight,
    required this.at,
    this.raw,
  });

  final String source;
  final String event;
  final int weight;
  final DateTime at;

  /// Raw value from the detection API — kept for diagnostics only, never
  /// surfaced in production UI.
  final Object? raw;

  @override
  String toString() =>
      '[${at.toIso8601String()}] $source | $event | w=$weight | raw=$raw';
}

// ─────────────────────────────────────────────────────────────────────────────
// CATEGORY CAPS  — prevents any single detection family from dominating the
// score; attacker must trigger multiple independent signals to reach "block".
//
// Tuning guide:
//   integrity  : raised to 55 so sig_mismatch(30) + tamper(30) can both land
//   environment: emulator/JB signals — capped lower; many legit edge cases
//   debug      : debugger/hook — medium cap; tracer_pid alone should degrade
//   heuristic  : soft signals (build props, JRD issue list) — lowest cap
// ─────────────────────────────────────────────────────────────────────────────

const _kCategoryCaps = <String, int>{
  'integrity': 55,
  'environment': 35,
  'debug': 40,
  'heuristic': 20,
};

// Compound bonuses added AFTER cap logic — rewarded only when two independent
// subsystems both fire, which sharply raises confidence.
const _kCompoundBonuses = <({String a, String b}), int>{
  (a: 'root_safe_device', b: 'frida_port'): 20,
  (a: 'jailbreak_safe_device', b: 'frida_port'): 20,
  (a: 'tracer_pid', b: 'proc_maps'): 15,
  (a: 'sig_mismatch', b: 'tampered_jrd'): 15,
};

// Sliding window: signals older than this are ignored by the scorer.
const _kWindowMinutes = 10;

// Min / max jitter for the periodic background check, in seconds.
const _kMonitorMinSecs = 30;
const _kMonitorJitterSecs = 60;

// ─────────────────────────────────────────────────────────────────────────────
// RASP CONTROLLER — singleton; call runStartupChecks() before the first frame,
// then startMonitoring() once the app is running.
// ─────────────────────────────────────────────────────────────────────────────

class RaspController {
  RaspController._();

  static final instance = RaspController._();

  // ── Platform channel ───────────────────────────────────────────────────────
  //
  // Must match the channel name registered in:
  //   Android → MainActivity.kt  (MethodChannel("com.yourapp/rasp"))
  //   iOS     → AppDelegate.swift (FlutterMethodChannel(name: "com.yourapp/rasp"))

  static const _channel = MethodChannel('rasp_service');

  // ── Trust anchors  (fill these in; never commit plaintext values) ──────────
  //
  // Android: apksigner verify --print-certs release.apk | grep SHA-256
  //          (use the Play App Signing cert from Play Console for store builds)
  //
  // iOS: 10-character Apple Team ID from developer.apple.com,
  //      no trailing dot.

  static const _expectedAndroidSigHash = 'YOUR_RELEASE_SHA256_HEX_HERE';
  static const _expectedIosTeamId = 'YOUR_TEAM_ID';

  // ── Internal state  ────────────────────────────────────────────────────────

  final List<RaspSignal> _signals = [];
  final List<RaspTraceEntry> _traceLog = [];

  Timer? _monitorTimer;
  bool _disposed = false;

  // ─────────────────────────────────────────────────────────────────────────
  // PUBLIC API
  // ─────────────────────────────────────────────────────────────────────────

  /// Run the full detection suite synchronously before the first frame.
  /// Expected wall-clock cost: 100–250 ms on a mid-range real device.
  ///
  /// Returns the [RaspResponse] that the caller should act on immediately.
  Future<RaspResponse> runStartupChecks() async {
    _assertNotDisposed();
    _signals.clear();
    _traceLog.clear();

    await Future.wait<void>([
      _runSignatureCheck(),
      _runSafeDevice(),
      _runJrd(),
      _runDeviceInfo(),
      _runNativeShims(),
    ]);
    

    final response = currentResponse;
    AppLogger.warning('[RASP] startup score=$riskScore response=$response');
    return response;
  }

  /// Start the randomised background monitoring loop.
  /// Idempotent — safe to call multiple times.
  void startMonitoring() {
    _assertNotDisposed();
    if (_monitorTimer?.isActive ?? false) return;
    _scheduleNextCycle();
  }

  /// Call this from [WidgetsBindingObserver.didChangeAppLifecycleState] when
  /// the app returns to the foreground — a device can be rooted after launch.
  Future<RaspResponse> onAppResumed() async {
    _assertNotDisposed();
    await runStartupChecks();
    return currentResponse;
  }

  /// Inject a signal from an external source (e.g. [dio] bad-certificate
  /// callback, server-side integrity verdict).
  void addExternalSignal(String source, String category, int weight) {
    _assertNotDisposed();
    _record(source, category, weight, event: 'external');
  }

  /// Cancel the monitoring timer and release resources.
  /// After calling this, the instance must not be used again.
  void dispose() {
    _monitorTimer?.cancel();
    _monitorTimer = null;
    _disposed = true;
  }

  // ─────────────────────────────────────────────────────────────────────────
  // SCORING  — pure computation; no side-effects, no logging inside
  // ─────────────────────────────────────────────────────────────────────────

  /// Returns a 0–100 risk score computed over the last [_kWindowMinutes].
  int get riskScore {
    final cutoff =
        DateTime.now().subtract(const Duration(minutes: _kWindowMinutes));

    final recent = _signals.where((s) => s.at.isAfter(cutoff)).toList();

    // Step 1 — sum per category, then apply caps
    final Map<String, int> categoryTotals = {};
    for (final s in recent) {
      categoryTotals[s.category] = (categoryTotals[s.category] ?? 0) + s.weight;
    }

    int total = 0;
    for (final entry in categoryTotals.entries) {
      final cap = _kCategoryCaps[entry.key] ?? 100;
      total += entry.value.clamp(0, cap);
    }

    // Step 2 — compound bonuses (added after caps to avoid gaming)
    final firedSources = recent.map((s) => s.source).toSet();
    for (final bonus in _kCompoundBonuses.entries) {
      if (firedSources.contains(bonus.key.a) &&
          firedSources.contains(bonus.key.b)) {
        total += bonus.value;
      }
    }

    return total.clamp(0, 100);
  }

  /// Derives the [RaspResponse] from the current [riskScore].
  /// Pure — reads score once, no side-effects.
  RaspResponse get currentResponse {
    final s = riskScore;
    if (s >= 85) return RaspResponse.block;
    if (s >= 60) return RaspResponse.invalidate;
    if (s >= 30) return RaspResponse.degrade;
    return RaspResponse.monitor;
  }

  // ─────────────────────────────────────────────────────────────────────────
  // DIAGNOSTICS  — call only in debug/internal builds; strip from release
  // ─────────────────────────────────────────────────────────────────────────

  /// Returns a human-readable dump of the trace log + final score.
  /// Gate with [kDebugMode] or a compile-time flag before calling.
  String dumpDiagnostics() {
    final buf = StringBuffer()..writeln('==== RASP TRACE ====');
    for (final t in _traceLog) {
      buf.writeln(t.toString());
    }
    buf.writeln('\n==== CATEGORY TOTALS ====');

    final cutoff =
        DateTime.now().subtract(const Duration(minutes: _kWindowMinutes));
    final recent = _signals.where((s) => s.at.isAfter(cutoff)).toList();
    final Map<String, int> totals = {};
    for (final s in recent) {
      totals[s.category] = (totals[s.category] ?? 0) + s.weight;
    }
    for (final e in totals.entries) {
      final cap = _kCategoryCaps[e.key] ?? 100;
      buf.writeln('  ${e.key}: raw=${e.value} capped=${e.value.clamp(0, cap)}');
    }

    buf
      ..writeln('\n==== FINAL SCORE ====')
      ..writeln(riskScore)
      ..writeln('==== RESPONSE ====')
      ..writeln(currentResponse.name);

    return buf.toString();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // LAYER 1 — SIGNATURE / INTEGRITY
  //
  // Highest-weight single signal. A signing cert mismatch means the APK/IPA
  // has been repackaged and re-signed by an attacker.
  // ─────────────────────────────────────────────────────────────────────────

  Future<void> _runSignatureCheck() async {
    try {
      final hash =
          await _channel.invokeMethod<String>('getSignatureHash') ?? '';

      if (hash.isEmpty) {
        // Channel succeeded but returned empty — abnormal; log, don't score.
        _log('signature', 'hash_empty', 0, raw: hash);
        return;
      }

      final expected =
          Platform.isAndroid ? _expectedAndroidSigHash : _expectedIosTeamId;

      final mismatch = hash != expected;

      _record(
        'sig_mismatch',
        'integrity',
        mismatch ? 30 : 0,
        event: mismatch ? 'mismatch' : 'valid',
        raw: hash,
      );
    } catch (e) {
      // Channel error → do NOT score; native may be legitimately unavailable
      // in test builds. Log for diagnostics only.
      _log('signature', 'channel_error', 0, raw: e.toString());
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // LAYER 2 — SAFE_DEVICE
  //
  // Uses its own Kotlin/Swift — no external native-lib dependency.
  // Covers: root, JB, emulator, mock location, dev mode, external storage.
  // All signals run in parallel; a thrown exception inside one does not
  // prevent the others from completing.
  // ─────────────────────────────────────────────────────────────────────────

  Future<void> _runSafeDevice() async {
    await Future.wait<void>([
      _safeDeviceCheck(
        name: 'jailbreak_safe_device',
        category: 'environment',
        weight: 22,
        // isJailBroken covers iOS (Cydia paths, sandbox escape, dyld list,
        // palera1n indicators) and Android root on the same call.
        getter: () => SafeDevice.isJailBroken,
      ),
      _safeDeviceCheck(
        name: 'root_safe_device',
        category: 'environment',
        weight: 22,
        getter: () => SafeDevice.isJailBrokenCustom,
      ),
      _safeDeviceCheck(
        name: 'emulator_safe_device',
        category: 'environment',
        weight: 18,
        // isRealDevice: false on emulators, simulators, and some CI runners.
        getter: () async => !(await SafeDevice.isRealDevice),
      ),
      _safeDeviceCheck(
        name: 'external_storage',
        category: 'heuristic',
        weight: 10,
        // APK installed on external storage → likely sideloaded.
        // Android-only; safe_device returns false on iOS.
        getter: () => SafeDevice.isOnExternalStorage,
      ),
      _safeDeviceCheck(
        name: 'dev_mode',
        category: 'debug',
        weight: 8,
        // Developer options enabled — low weight; many legit dev devices.
        getter: () => SafeDevice.isDevelopmentModeEnable,
      ),
    ]);
  }

  /// Runs a single safe_device boolean getter, handles exceptions, and records
  /// the result. Extracted to avoid repetitive try/catch boilerplate.
  Future<void> _safeDeviceCheck({
    required String name,
    required String category,
    required int weight,
    required Future<bool> Function() getter,
  }) async {
    try {
      final fired = await getter();
      _record(
        name,
        category,
        fired ? weight : 0,
        event: fired ? 'detected' : 'clean',
        raw: fired,
      );
    } catch (e) {
      _log('safe_device:$name', 'plugin_error', 0, raw: e.toString());
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // LAYER 3 — JAILBREAK_ROOT_DETECTION (jailbreak_root_detection package)
  //
  // Wraps RootBeer (Android) + IOSSecuritySuite (iOS) — two battle-tested
  // native libraries that operate independently of safe_device's code path.
  // Running both means an attacker hooking one MethodChannel return still
  // gets caught by the other library's native export.
  // ─────────────────────────────────────────────────────────────────────────

  Future<void> _runJrd() async {
    try {
      // isJailBroken: RootBeer combined verdict (Android) / IOSS (iOS)
      final isJb = await JailbreakRootDetection.instance.isJailBroken;
      _record(
        'jailbreak_jrd',
        'environment',
        isJb ? 22 : 0,
        event: isJb ? 'detected' : 'clean',
        raw: isJb,
      );

      // isRealDevice: false on emulators and simulators
      final isReal = await JailbreakRootDetection.instance.isRealDevice;
      _record(
        'emulator_jrd',
        'environment',
        isReal ? 0 : 18,
        event: isReal ? 'clean' : 'detected',
        raw: isReal,
      );

      // isTampered: signature mismatch check from the JRD side — runs
      // independently of our native shim getSignatureHash, so a bypass
      // of one still gets caught by the other.
      final pkgName = await _getPackageName();
      if (pkgName.isNotEmpty) {
        final tampered =
            await JailbreakRootDetection.instance.isTampered(pkgName);
        _record(

          'tampered_jrd',
          'integrity',
          tampered ? 30 : 0,
          event: tampered ? 'detected' : 'clean',
          raw: tampered,
        );
      }

      // checkForIssues: list of granular RootBeer / IOSS sub-signals.
      // Deduplicate against signals we already record individually to
      // avoid double-counting the same physical event.
      final issues = await JailbreakRootDetection.instance.checkForIssues;
      final deduplicated = issues
          .map((e) => e.name)
          .where((name) =>
              !const {'devMode', 'jailbroken', 'emulator'}.contains(name))
          .toList();

      _record(
        'jrd_issue_list',
        'heuristic',
        (deduplicated.length * 4).clamp(0, 20),
        event: deduplicated.isEmpty ? 'clean' : 'issues_found',
        raw: deduplicated,
      );
    } catch (e) {
      _log('jrd', 'plugin_error', 0, raw: e.toString());
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // LAYER 4 — DEVICE_INFO_PLUS EMULATOR HEURISTICS
  //
  // Checks Build.FINGERPRINT / Build.MODEL / Build.HARDWARE directly.
  // Catches emulators that spoof RootBeer/safe_device but cannot spoof
  // low-level build properties without a full custom ROM.
  // Android only — iOS Simulator is reliably caught by safe_device/JRD.
  // ─────────────────────────────────────────────────────────────────────────

  Future<void> _runDeviceInfo() async {
    if (!Platform.isAndroid) return;

    try {
      final info = await DeviceInfoPlugin().androidInfo;
      int score = 0;

      final fp = info.fingerprint.toLowerCase();
      // Emulator fingerprints always contain one of these substrings.
      if (fp.contains('generic') ||
          fp.contains(':sdk/') ||
          fp.contains('unknown') ||
          fp.contains('test-keys')) {
        score += 10;
      }

      // Build.MODEL is "sdk", "Emulator", "Android SDK built for x86", etc.
      final model = info.model.toLowerCase();
      if (model.contains('emulator') ||
          model == 'sdk' ||
          model.contains('android sdk')) {
        score += 10;
      }

      // Build.HARDWARE is "goldfish" (AOSP emulator) or "ranchu" (AVD).
      final hw = info.hardware.toLowerCase();
      if (const {'goldfish', 'ranchu', 'vbox86', 'unknown'}.contains(hw)) {
        score += 10;
      }


      // Build.BRAND "generic" only appears on emulators/GSI images.
      if (info.brand.toLowerCase() == 'generic') score += 5;

      _record(
        'build_props_emulator',
        'environment',
        score.clamp(0, 25),
        event: score > 0 ? 'suspicious' : 'clean',
        raw: {
          'fingerprint': info.fingerprint,
          'model': info.model,
          'hardware': info.hardware,
          'brand': info.brand,
        },
      );
    } catch (e) {
      _log('device_info', 'plugin_error', 0, raw: e.toString());
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // LAYER 5 — NATIVE SHIMS
  //
  // These three checks require a thin MethodChannel shim (~80 lines Kotlin,
  // ~70 lines Swift) because no pub.dev plugin covers them:
  //
  //   checkFridaPort  → TCP connect to 127.0.0.1:27042–27044.
  //                     Frida server listens here by default.
  //   checkProcMaps   → Read /proc/self/maps for "frida", "gadget",
  //                     "linjector", "xposed" — catches port-randomised Frida
  //                     and embedded Frida Gadget.
  //   checkTracerPid  → Read TracerPid from /proc/self/status (Android) or
  //                     check P_TRACED sysctl flag (iOS).
  //                     Non-zero = debugger is attached.
  //
  // All three run in parallel. A channel exception is logged but not scored —
  // a missing shim in a test build should not trigger the response engine.
  // ─────────────────────────────────────────────────────────────────────────

  Future<void> _runNativeShims() async {
    await Future.wait<void>([
      _nativeCheck(
        method: 'checkFridaPort',
        name: 'frida_port',
        category: 'debug',
        // Very high confidence: Frida server is actively running.
        weight: 40,
      ),
      _nativeCheck(
        method: 'checkProcMaps',
        name: 'proc_maps',
        category: 'debug',
        // Catches embedded Frida Gadget and port-randomised Frida server.
        weight: 38,
      ),
      _nativeCheck(
        method: 'checkTracerPid',
        name: 'tracer_pid',
        category: 'debug',
        // Debugger attached at the OS level.
        weight: 35,
      ),
    ]);
  }

  /// Invokes a boolean native method, records the result.
  Future<void> _nativeCheck({
    required String method,
    required String name,
    required String category,
    required int weight,
  }) async {
    try {
      final fired = await _channel.invokeMethod<bool>(method) ?? false;
      _record(
        name,
        category,
        fired ? weight : 0,
        event: fired ? 'detected' : 'clean',
        raw: fired,
      );
    } catch (e) {
      // MissingPluginException → shim not registered (debug/test build).
      // PlatformException    → native threw; treat as unknown, not threat.
      _log('native:$method', 'channel_error', 0, raw: e.toString());
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // BACKGROUND MONITORING LOOP
  //
  // Uses Timer, not while+await, so it never blocks the event loop.
  // Each cycle picks 2 random checks from the pool — rotating which checks
  // run makes the pattern unrecognisable to an attacker timing MethodChannel
  // traffic.
  // ─────────────────────────────────────────────────────────────────────────

  void _scheduleNextCycle() {
    if (_disposed) return;

    final delay = Duration(
      seconds: _kMonitorMinSecs + Random().nextInt(_kMonitorJitterSecs),
    );

    _monitorTimer = Timer(delay, () async {
      if (_disposed) return;

      final checks = <Future<void> Function()>[
        _runSafeDevice,
        _runJrd,
        _runDeviceInfo,
        _runNativeShims,
      ]..shuffle(Random());

      for (final check in checks.take(2)) {
        await check();
      }

      final score = riskScore;
      AppLogger.warning(
          '[RASP] periodic score=$score response=${currentResponse.name}');

      _scheduleNextCycle();
    });
  }

  // ─────────────────────────────────────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────────────────────────────────────

  /// Records a signal (weight > 0) and appends a trace entry unconditionally.
  void _record(
    String source,
    String category,
    int weight, {
    String event = 'detected',
    Object? raw,
  }) {
    // Trace everything regardless of weight — needed for diagnostics.
    _traceLog.add(RaspTraceEntry(
      source: source,
      event: event,
      weight: weight,
      at: DateTime.now(),
      raw: raw,
    ));

    if (weight <= 0) return;

    _signals.add(RaspSignal(
      source: source,
      category: category,
      weight: weight,
      at: DateTime.now(),
    ));

    AppLogger.info('[RASP][$event] $source => $weight');
  }

  /// Appends a trace-only entry (no signal recorded, no scoring).
  void _log(String source, String event, int weight, {Object? raw}) {
    _traceLog.add(RaspTraceEntry(
      source: source,
      event: event,
      weight: weight,
      at: DateTime.now(),
      raw: raw,
    ));
  }

  /// Returns the app package name; falls back to an empty string on error
  /// so the caller can skip the isTampered check gracefully.
  Future<String> _getPackageName() async {
    try {
      if (Platform.isAndroid) {
        // package name is not directly available from device_info_plus;
        // read it via the native channel which already knows it.
        return await _channel.invokeMethod<String>('getPackageName') ?? '';
      }
      // iOS: bundle identifier via native shim
      return await _channel.invokeMethod<String>('getPackageName') ?? '';
    } catch (_) {
      return '';
    }
  }

  void _assertNotDisposed() {
    if (_disposed) {
      throw StateError(
        'RaspController has been disposed. '
        'Do not call methods after dispose().',
      );
    }
  }
}
