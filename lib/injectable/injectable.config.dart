// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../core/cubits/language_cubit/language_cubit.dart' as _i212;
import '../core/cubits/theme_cubit/theme_cubit.dart' as _i138;
import '../core/initial_app_mixin.dart' as _i153;
import '../core/services/network_service/network_service.dart' as _i377;
import '../core/services/network_service/network_service_impl.dart' as _i837;
import '../core/utils/localization/localization_service.dart' as _i743;
import '../core/utils/localization/localization_support.dart' as _i705;
import '../core/utils/navigation_service.dart' as _i937;
import '../core/utils/secure_storage/secure_storage_module.dart' as _i482;
import '../core/utils/secure_storage/secure_storage_service.dart' as _i226;
import '../core/utils/secure_storage/secure_storage_service_impl.dart' as _i81;
import '../core/utils/shared_preferences/shared_prefs_module.dart' as _i712;
import '../core/utils/shared_preferences/shared_prefs_service.dart' as _i769;
import '../core/utils/shared_preferences/shared_prefs_service_impl.dart'
    as _i774;
import '../features/auth/data/repo_impl/auth_repo_impl.dart' as _i855;
import '../features/auth/domain/repo/auth_repo.dart' as _i113;
import '../features/auth/presentation/bloc/auth_cubit/auth_cubit.dart' as _i435;
import '../features/auth/presentation/bloc/login_bloc/login_bloc.dart' as _i551;
import '../features/dashboard/presentation/bloc/bottom_nav_cubit/bottom_nav_cubit.dart'
    as _i296;
import '../features/profile/presentation/bloc/profile_bloc/profile_bloc.dart'
    as _i848;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final sharedPrefsModule = _$SharedPrefsModule();
    final secureStorageModule = _$SecureStorageModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPrefsModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i212.LanguageCubit>(() => _i212.LanguageCubit());
    gh.lazySingleton<_i138.ThemeCubit>(() => _i138.ThemeCubit());
    gh.lazySingleton<_i153.InitialAppMixin>(() => _i153.InitialAppMixin());
    gh.lazySingleton<_i743.LocalizationService>(
        () => _i743.LocalizationService());
    gh.lazySingleton<_i705.LocalizationSupport>(
        () => _i705.LocalizationSupport());
    gh.lazySingleton<_i937.NavigationService>(() => _i937.NavigationService());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => secureStorageModule.secureprefs);
    gh.lazySingleton<_i435.AuthCubit>(() => _i435.AuthCubit());
    gh.lazySingleton<_i551.LoginBloc>(() => _i551.LoginBloc());
    gh.lazySingleton<_i296.BottomNavCubit>(() => _i296.BottomNavCubit());
    gh.lazySingleton<_i848.ProfileBloc>(() => _i848.ProfileBloc());
    gh.lazySingleton<_i226.SecureStorageService>(
        () => _i81.SecureStorageServiceImpl(gh<_i558.FlutterSecureStorage>()));
    gh.lazySingleton<_i769.SharedPrefsService>(
        () => _i774.SharedPrefsServiceImpl(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i377.NetworkService>(() => _i837.NetworkServiceImpl());
    gh.lazySingleton<_i113.AuthRepo>(() => _i855.AuthRepoImpl());
    return this;
  }
}

class _$SharedPrefsModule extends _i712.SharedPrefsModule {}

class _$SecureStorageModule extends _i482.SecureStorageModule {}
