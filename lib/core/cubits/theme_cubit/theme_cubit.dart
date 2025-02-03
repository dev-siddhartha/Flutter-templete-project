import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/core/constants/theme_constants.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/core/utils/theme/global_theme.dart';

@lazySingleton
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void getThemeFromPreference() {
    String? selectedTheme = getIt<SharedPrefsService>().getString(
      key: SharedPrefsKeys.theme,
    );

    if (selectedTheme != null && selectedTheme.isNotEmpty) {
      ThemeEnum themeEnum = GlobalTheme.getThemeEnum(selectedTheme);

      switch (themeEnum) {
        case ThemeEnum.light:
          emit(ThemeMode.light);
        case ThemeEnum.dark:
          emit(ThemeMode.dark);
        case ThemeEnum.system:
          emit(ThemeMode.system);
      }
    }
  }

  void changeTheme(String selectedTheme) {
    ThemeEnum themeEnum = GlobalTheme.getThemeEnum(selectedTheme);

    getIt<SharedPrefsService>().setString(
      key: SharedPrefsKeys.theme,
      value: selectedTheme,
    );

    switch (themeEnum) {
      case ThemeEnum.light:
        emit(ThemeMode.light);
      case ThemeEnum.dark:
        emit(ThemeMode.dark);
      case ThemeEnum.system:
        emit(ThemeMode.system);
    }
  }
}
