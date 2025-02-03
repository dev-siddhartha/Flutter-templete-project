// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../cubits/theme_cubit/theme_cubit.dart' as _i515;
import '../utils/shared_preferences/shared_prefs_module.dart' as _i16;
import '../utils/shared_preferences/shared_prefs_service.dart' as _i947;
import '../utils/shared_preferences/shared_prefs_service_impl.dart' as _i634;

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
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPrefsModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i515.ThemeCubit>(() => _i515.ThemeCubit());
    gh.lazySingleton<_i947.SharedPrefsService>(
        () => _i634.SharedPrefsServiceImpl(gh<_i460.SharedPreferences>()));
    return this;
  }
}

class _$SharedPrefsModule extends _i16.SharedPrefsModule {}
