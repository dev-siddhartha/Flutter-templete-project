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

import '../core/cubits/language_cubit/language_cubit.dart' as _i212;
import '../core/cubits/theme_cubit/theme_cubit.dart' as _i138;
import '../core/utils/localization/localization_service.dart' as _i743;
import '../core/utils/localization/localization_support.dart' as _i705;
import '../core/utils/navigation_service.dart' as _i937;
import '../core/utils/shared_preferences/shared_prefs_module.dart' as _i712;
import '../core/utils/shared_preferences/shared_prefs_service.dart' as _i769;
import '../core/utils/shared_preferences/shared_prefs_service_impl.dart'
    as _i774;

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
    gh.lazySingleton<_i212.LanguageCubit>(() => _i212.LanguageCubit());
    gh.lazySingleton<_i138.ThemeCubit>(() => _i138.ThemeCubit());
    gh.lazySingleton<_i743.LocalizationService>(
        () => _i743.LocalizationService());
    gh.lazySingleton<_i705.LocalizationSupport>(
        () => _i705.LocalizationSupport());
    gh.lazySingleton<_i937.NavigationService>(() => _i937.NavigationService());
    gh.lazySingleton<_i769.SharedPrefsService>(
        () => _i774.SharedPrefsServiceImpl(gh<_i460.SharedPreferences>()));
    return this;
  }
}

class _$SharedPrefsModule extends _i712.SharedPrefsModule {}
