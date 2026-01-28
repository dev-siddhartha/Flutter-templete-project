import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/features/auth/data/service/auth_service.dart';
import 'package:flutter_template/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:flutter_template/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

@lazySingleton
class InitialAppMixin {
  List<String> visitedBottomNavBar = [];

  /// call when app is initialized
  void fetchAppInitialData() {}

  /// call when user is logged in
  void fetchLoggedInInitialData() {
    getIt<ProfileBloc>().add(GetProfileEvent());
  }

  void fetchHomeInitialData() {}

  void fetchHistoryInitialData() {}

  void fetchProfileInitialData() {}

  void logout() {
    AuthService().clearUserProfile();
    getIt<AuthCubit>().login(false);
  }
}
