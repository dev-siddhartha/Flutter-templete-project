import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/core/utils/logger/app_logger.dart';
import 'package:go_router/go_router.dart';

@lazySingleton
class NavigationService {
  final GlobalKey<NavigatorState> rootNavigatorKey;

  NavigationService() : rootNavigatorKey = GlobalKey<NavigatorState>();

  BuildContext get _context {
    final ctx = rootNavigatorKey.currentContext;
    if (ctx == null) {
      throw Exception("Navigation not ready");
    }
    return ctx;
  }

  /// for maintaining history
  final List<String> _history = [];

  /// for navigation audit trail
  final List<String> _logs = [];

  List<String> get history => List.unmodifiable(_history);
  List<String> get logs => List.unmodifiable(_logs);

  String? get currentRoute => _history.isNotEmpty ? _history.last : null;

  void _log(String action, String route, {Object? extra}) {
    final entry =
        "[NAV] $action -> $route ${extra != null ? '| extra: $extra' : ''}";

    _logs.add(entry);

    // Print full current stack snapshot (what you asked for)
    AppLogger.info(entry);
    AppLogger.info("STACK: $_history");
  }

  Future<T?> navigateTo<T>(String routeName, {Object? extra}) {
    _history.add(routeName);
    _log("PUSH", routeName, extra: extra);

    return _context.pushNamed<T>(routeName, extra: extra);
  }

  void pushAndRemoveUntil(String routeName, {Object? extra}) {
    _history
      ..clear()
      ..add(routeName);

    _log("GO (RESET STACK)", routeName, extra: extra);

    _context.goNamed(routeName, extra: extra);
  }

  void popUntil(String targetRoute) {
    if (!_history.contains(targetRoute)) return;

    while (_history.isNotEmpty && _history.last != targetRoute) {
      final removed = _history.removeLast();
      _log("POP_UNTIL_REMOVE", removed);
      _context.pop();
    }

    _log("POP_UNTIL_END", targetRoute);
  }

  void goBack<T extends Object?>([T? result]) {
    final removed = _history.isNotEmpty ? _history.removeLast() : null;

    _log("POP", removed ?? "null");

    _context.pop(result);
  }

  void pushReplacement(String routeName, {Object? extra}) {
    if (_history.isNotEmpty) {
      _history.removeLast();
    }
    _history.add(routeName);

    _log("REPLACE", routeName, extra: extra);

    _context.pushReplacementNamed(routeName, extra: extra);
  }

  bool canPop() => _context.canPop();
}
