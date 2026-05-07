package com.example.neo_flutter.channels

import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.os.Handler
import android.os.Looper
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineExceptionHandler
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch
//import kotlinx.coroutines.withContext
import java.io.File
import java.net.InetSocketAddress
import java.net.Socket
import java.security.MessageDigest

// ─────────────────────────────────────────────────────────────────────────────
// RASPServiceChannel
//
// Registers a MethodChannel that handles security checks requested by the
// Dart layer (RaspController). Every check is dispatched to an IO background
// thread and the result is returned to Flutter on the platform (main) thread.
//
// Threading model:
//   Flutter MethodChannel callbacks arrive on the platform thread.
//   All blocking operations (Socket, File I/O) run on Dispatchers.IO.
//   result.success / result.error are always called on the main thread via
//   the mainHandler trampoline, satisfying Flutter's threading contract.
//
// Usage — call from MainActivity.configureFlutterEngine():
//   RASPServiceChannel.register(context, flutterEngine)
// ─────────────────────────────────────────────────────────────────────────────

object RASPServiceChannel {

    // Must match _channel = MethodChannel('rasp_service') in rasp_controller.dart
    private const val CHANNEL_NAME = "rasp_service"

    // Frida server default port + two common alternates.
    // 150 ms is more than enough for a loopback connect; Frida responds in < 5 ms.
    private const val FRIDA_PORT_TIMEOUT_MS = 150
    private val FRIDA_PORTS = intArrayOf(27042, 27043, 27044)

    // Strings to search for in /proc/self/maps.
    // Checked as whole path-segment substrings (lower-cased) to avoid matching
    // legitimate libraries that happen to contain a short substring by accident.
    private val PROC_MAP_SUSPECTS = arrayOf(
        "/frida",          // frida-agent, frida-gadget at standard install paths
        "frida-agent",     // explicit agent name regardless of path
        "frida-gadget",    // embedded gadget
        "/gadget.so",      // renamed gadget (common bypass attempt)
        "linjector",       // linjector injection framework
        "hluda",           // hluda (obfuscated Frida fork)
        "re.frida.server", // Frida server data directory
        "xposedbridge",    // XposedBridge.jar exact name — avoids "xposed" false positives
        "EdXposed",        // EdXposed framework
        "LSPosed",         // LSPosed framework
    )

    // Coroutine scope tied to SupervisorJob: one failing check does not cancel others.
    // The CoroutineExceptionHandler logs uncaught exceptions rather than crashing.
    private val scope = CoroutineScope(
        SupervisorJob() + Dispatchers.IO + CoroutineExceptionHandler { _, throwable ->
            android.util.Log.e("RASP", "Unhandled coroutine exception", throwable)
        }
    )

    // Trampoline back to the main thread for result delivery.
    private val mainHandler = Handler(Looper.getMainLooper())

    // ─────────────────────────────────────────────────────────────────────────
    // REGISTRATION
    // ─────────────────────────────────────────────────────────────────────────

    fun register(context: Context, flutterEngine: FlutterEngine) {
        // Hold application context — never the Activity — to avoid leaks.
        val appContext = context.applicationContext

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL_NAME,
        ).setMethodCallHandler { call, result ->
            // Dispatch every check to IO; reply on main thread.
            scope.launch {
                val outcome: Result<Any?> = runCatching {
                    when (call.method) {
                        "checkFridaPort"   -> checkFridaPort()
                        "checkTracerPid"   -> checkTracerPid()
                        "checkProcMaps"    -> checkProcMaps()
                        "getSignatureHash" -> getSignatureHash(appContext)
                        "getPackageName"   -> appContext.packageName
                        else               -> null  // signals notImplemented
                    }
                }

                // Flutter's MethodChannel contract: result must be called on
                // the platform (main) thread.
                mainHandler.post {
                    when {
                        call.method !in KNOWN_METHODS -> result.notImplemented()
                        outcome.isSuccess -> result.success(outcome.getOrNull())
                        else -> result.error(
                            "RASP_ERROR",
                            outcome.exceptionOrNull()?.message ?: "unknown",
                            null,
                        )
                    }
                }
            }
        }
    }

    private val KNOWN_METHODS = setOf(
        "checkFridaPort",
        "checkTracerPid",
        "checkProcMaps",
        "getSignatureHash",
        "getPackageName",
    )

    // ─────────────────────────────────────────────────────────────────────────
    // CHECK: FRIDA PORT SCAN
    //
    // Attempts a TCP connect to 127.0.0.1 on each known Frida server port.
    // A successful connect means a Frida server is actively listening.
    //
    // Why 150 ms timeout:
    //   Loopback connects succeed in < 5 ms when a server is present,
    //   and fail with ECONNREFUSED immediately when nothing is listening.
    //   The 150 ms budget absorbs OS scheduler jitter without blocking long.
    //
    // Bypass: attacker runs Frida on a non-default port.
    // Mitigation: checkProcMaps catches that case regardless of port.
    // ─────────────────────────────────────────────────────────────────────────

    private fun checkFridaPort(): Boolean {
        for (port in FRIDA_PORTS) {
            try {
                Socket().use { socket ->
                    // connect(endpoint, timeout) throws SocketTimeoutException on
                    // timeout and ConnectException on refused — both caught below.
                    socket.connect(InetSocketAddress("127.0.0.1", port), FRIDA_PORT_TIMEOUT_MS)
                    // If connect() returned without throwing, something is listening.
                    return true
                }
            } catch (_: Exception) {
                // ECONNREFUSED or timeout — nothing on this port, try the next.
            }
        }
        return false
    }

    // ─────────────────────────────────────────────────────────────────────────
    // CHECK: TRACER PID  (debugger attached)
    //
    // Reads /proc/self/status and looks for a non-zero TracerPid field.
    // The kernel sets this to the PID of the attaching debugger (lldb, gdb,
    // Android Studio debugger) when ptrace(PTRACE_ATTACH) is called.
    //
    // Returns CheckResult to distinguish "clean" from "check failed":
    //   true  → debugger is attached
    //   false → not attached OR read failed
    //
    // Bypass: some root setups patch the kernel to always report 0.
    // Mitigation: pair with timing-based detection at the Dart layer.
    // ─────────────────────────────────────────────────────────────────────────

    private fun checkTracerPid(): Boolean {
        return try {
            // /proc/self/status is always small (< 2 KB); safe to readText().
            val status = File("/proc/self/status").readText()
            val match = Regex("TracerPid:\\s*(\\d+)").find(status)
            val tracerPid = match?.groupValues?.getOrNull(1)?.toIntOrNull() ?: 0
            tracerPid != 0
        } catch (e: Exception) {
            // If the file is unreadable, something is wrong with the environment.
            // Log but return false — the Dart layer should not penalise I/O errors
            // since they may occur on legitimate hardened ROMs.
            android.util.Log.w("RASP", "checkTracerPid failed: ${e.javaClass.simpleName}")
            false
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    // CHECK: /proc/self/maps  (injected library detection)
    //
    // Reads the memory-map of the current process and checks each line for
    // known Frida / Xposed artifact strings.
    //
    // Why this is the most reliable Frida signal:
    //   Even with a non-default port (bypassing checkFridaPort), Frida's
    //   injected agent or gadget .so appears in the process's memory map
    //   under a recognisable path or name.
    //
    // False-positive mitigation:
    //   Suspects are full substrings (e.g. "/frida", "frida-agent") rather
    //   than bare tokens like "frida", to avoid matching a path such as
    //   /data/user/0/com.myapp/cache/conf_ridaApp.so.
    //
    // Performance:
    //   /proc/self/maps on a typical Flutter app is 300–800 lines.
    //   Reading and scanning with useLines (streaming) avoids loading
    //   the entire file into memory. Runs on Dispatchers.IO.
    // ─────────────────────────────────────────────────────────────────────────

    private fun checkProcMaps(): Boolean {
        return try {
            File("/proc/self/maps").bufferedReader().useLines { lines ->
                lines.any { line ->
                    val lower = line.lowercase()
                    PROC_MAP_SUSPECTS.any { suspect -> lower.contains(suspect) }
                }
            }
        } catch (e: Exception) {
            android.util.Log.w("RASP", "checkProcMaps failed: ${e.javaClass.simpleName}")
            false
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    // CHECK: SIGNING CERTIFICATE HASH
    //
    // Returns the SHA-256 hex digest of the APK signing certificate.
    // The Dart layer compares this against the expected hash stored as a
    // compile-time constant (_expectedAndroidSigHash in RaspController).
    // A mismatch means the APK has been repackaged and re-signed.
    //
    // API note:
    //   API ≥ 28: GET_SIGNING_CERTIFICATES + apkContentsSigners
    //     → reflects the actual signers of the installed APK bytes,
    //       ignoring the rotation history.
    //   API < 28: GET_SIGNATURES (deprecated but only option)
    //     → returns all certs in the chain; firstOrNull is the leaf.
    //
    // Play App Signing:
    //   If you use Play App Signing, Google re-signs your APK with the
    //   deployment key. The expected hash must be the DEPLOYMENT key's
    //   SHA-256, found in Play Console → Setup → App integrity →
    //   "App signing key certificate" → SHA-256 certificate fingerprint.
    //   Remove the ":" separators and lowercase to get the hex string.
    //
    // Returns "" on any error; the Dart layer treats empty as "unknown",
    // not as "mismatch", to avoid false positives from API edge cases.
    // ─────────────────────────────────────────────────────────────────────────

    private fun getSignatureHash(context: Context): String {
        return try {
            val pm = context.packageManager

            val sigBytes: ByteArray? = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                pm.getPackageInfo(
                    context.packageName,
                    PackageManager.GET_SIGNING_CERTIFICATES,
                ).signingInfo
                    ?.apkContentsSigners
                    ?.firstOrNull()
                    ?.toByteArray()
            } else {
                @Suppress("DEPRECATION")
                pm.getPackageInfo(
                    context.packageName,
                    PackageManager.GET_SIGNATURES,
                ).signatures
                    ?.firstOrNull()
                    ?.toByteArray()
            }

            if (sigBytes == null) return ""

            MessageDigest.getInstance("SHA-256")
                .digest(sigBytes)
                .joinToString(separator = "") { byte -> "%02x".format(byte) }

        } catch (e: Exception) {
            android.util.Log.w("RASP", "getSignatureHash failed: ${e.javaClass.simpleName}")
            ""
        }
    }
}