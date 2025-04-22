import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/features/screens/screen_1.dart';
import 'package:flutter_template/features/screens/screen_2.dart';
import 'package:flutter_template/features/screens/screen_3.dart';
import 'package:go_router/go_router.dart';

class RouteConfig {
  static final GoRouter router = GoRouter(
    navigatorKey: NavigationService.rootNavigatorKey,
    initialLocation: RouteNames.initialRoute,
    routes: [
      GoRoute(path: RouteNames.initialRoute,name: RouteNames.initialRoute, builder: (context, state) => const Screen1(),),
      GoRoute(path: RouteNames.screen3,name: RouteNames.screen3, builder: (context, state) => const Screen3(),),
      GoRoute(path: RouteNames.screen2,name: RouteNames.screen2, builder: (context, state) => const Screen2(),),

  ],
  );
}