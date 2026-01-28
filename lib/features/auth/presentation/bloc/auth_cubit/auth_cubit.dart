import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/core/initial_app_mixin.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/features/dashboard/data/constants/dashboard_constants.dart';
import 'package:flutter_template/features/dashboard/presentation/bloc/bottom_nav_cubit/bottom_nav_cubit.dart';

@lazySingleton
class AuthCubit extends Cubit<bool> {
  AuthCubit() : super(false);

  void login(bool loggedIn, [bool redirect = true]) {
    getIt<SharedPrefsService>()
        .setBool(key: SharedPrefsKeys.isLoggedIn, value: loggedIn);
    if (redirect) {
      if (loggedIn) {
        _loadInitialData();
      }
      emit(loggedIn);
      getIt<BottomNavCubit>().updateScreen(BottomNavString.home);
    }
  }

  void checkLogin() {
    bool isLogged =
        getIt<SharedPrefsService>().getBool(key: SharedPrefsKeys.isLoggedIn) ??
            false;
    if (isLogged) {
      _loadInitialData();
    }
    emit(isLogged);
  }

  void _loadInitialData() {
    getIt<InitialAppMixin>().fetchLoggedInInitialData();
  }
}
