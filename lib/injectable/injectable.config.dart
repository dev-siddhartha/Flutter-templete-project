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
import '../core/services/localization/localization_service.dart' as _i321;
import '../core/services/navigation/navigation_service.dart' as _i648;
import '../core/services/network_service/network_service.dart' as _i377;
import '../core/services/network_service/network_service_impl.dart' as _i837;
import '../core/storage/cache/app_database.dart' as _i731;
import '../core/storage/cache/file_cache_service.dart' as _i104;
import '../core/storage/cache/local_cache_service.dart' as _i32;
import '../core/storage/cache/register_module.dart' as _i741;
import '../core/storage/secure_storage/secure_storage_module.dart' as _i478;
import '../core/storage/secure_storage/secure_storage_service.dart' as _i21;
import '../core/storage/secure_storage/secure_storage_service_impl.dart'
    as _i332;
import '../core/storage/shared_preferences/shared_prefs_module.dart' as _i656;
import '../core/storage/shared_preferences/shared_prefs_service.dart' as _i376;
import '../core/storage/shared_preferences/shared_prefs_service_impl.dart'
    as _i723;
import '../features/auth/repository/auth_repo.dart' as _i151;
import '../features/auth/repository/auth_repo_impl.dart' as _i637;
import '../features/auth/viewmodel/bloc/auth_cubit/auth_cubit.dart' as _i1029;
import '../features/auth/viewmodel/bloc/login_bloc/login_bloc.dart' as _i746;
import '../features/dashboard/viewmodel/bloc/bottom_nav_cubit/bottom_nav_cubit.dart'
    as _i752;
import '../features/profile/viewmodel/bloc/profile_bloc/profile_bloc.dart'
    as _i527;

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
    final registerModule = _$RegisterModule();
    final sharedPrefsModule = _$SharedPrefsModule();
    final secureStorageModule = _$SecureStorageModule();
    await gh.factoryAsync<_i731.AppDatabase>(
      () => registerModule.db(),
      preResolve: true,
    );
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPrefsModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i104.FileCacheService>(() => _i104.FileCacheService());
    gh.lazySingleton<_i212.LanguageCubit>(() => _i212.LanguageCubit());
    gh.lazySingleton<_i138.ThemeCubit>(() => _i138.ThemeCubit());
    gh.lazySingleton<_i153.InitialAppMixin>(() => _i153.InitialAppMixin());
    gh.lazySingleton<_i321.LocalizationService>(
        () => _i321.LocalizationService());
    gh.lazySingleton<_i648.NavigationService>(() => _i648.NavigationService());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => secureStorageModule.secureprefs);
    gh.lazySingleton<_i1029.AuthCubit>(() => _i1029.AuthCubit());
    gh.lazySingleton<_i746.LoginBloc>(() => _i746.LoginBloc());
    gh.lazySingleton<_i752.BottomNavCubit>(() => _i752.BottomNavCubit());
    gh.lazySingleton<_i527.ProfileBloc>(() => _i527.ProfileBloc());
    gh.lazySingleton<_i377.NetworkService>(() => _i837.NetworkServiceImpl());
    gh.lazySingleton<_i151.AuthRepo>(() => _i637.AuthRepoImpl());
    gh.singleton<_i32.LocalCacheService>(
        () => _i32.LocalCacheService(gh<_i731.AppDatabase>()));
    gh.lazySingleton<_i21.SecureStorageService>(
        () => _i332.SecureStorageServiceImpl(gh<_i558.FlutterSecureStorage>()));
    gh.lazySingleton<_i376.SharedPrefsService>(
        () => _i723.SharedPrefsServiceImpl(gh<_i460.SharedPreferences>()));
    return this;
  }
}

class _$RegisterModule extends _i741.RegisterModule {}

class _$SharedPrefsModule extends _i656.SharedPrefsModule {}

class _$SecureStorageModule extends _i478.SecureStorageModule {}
