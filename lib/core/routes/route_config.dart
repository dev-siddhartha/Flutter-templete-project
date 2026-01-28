import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:flutter_template/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_template/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter_template/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_template/features/history/presentation/screens/history_screen.dart';
import 'package:flutter_template/features/profile/presentation/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';

class RouteConfig {
  static final GoRouter router = GoRouter(
    navigatorKey: NavigationService.rootNavigatorKey,
    initialLocation: RouteNames.initialRoute,
    routes: [
      GoRoute(
        path: RouteNames.initialRoute,
        name: RouteNames.initialRoute,
        redirect: (context, state) {
          return getIt<AuthCubit>().state
              ? RouteNames.dashboardRoute
              : RouteNames.loginRoute;
        },
      ),
      GoRoute(
        path: RouteNames.loginRoute,
        name: RouteNames.loginRoute,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.dashboardRoute,
        name: RouteNames.dashboardRoute,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: RouteNames.homeScreenRoute,
        name: RouteNames.homeScreenRoute,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RouteNames.historyScreenRoute,
        name: RouteNames.historyScreenRoute,
        builder: (context, state) => const HistoryScreen(),
      ),
      GoRoute(
        path: RouteNames.profileScreenRoute,
        name: RouteNames.profileScreenRoute,
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}
