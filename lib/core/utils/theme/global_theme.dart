import 'package:flutter_template/core/constants/theme_constants.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/core/utils/theme/dark_theme.dart';
import 'package:flutter_template/core/utils/theme/light_theme.dart';

class GlobalTheme {
  GlobalTheme._();

  static const List<String> appThemes = [
    'Light',
    'Dark',
    'System',
  ];

  static ThemeData lightThemeData = themeData(
    LightTheme.lightColorScheme,
    LightTheme.lightFocusColor,
  );

  static ThemeData darkThemeData = themeData(
    DarkTheme.darkColorScheme,
    DarkTheme.darkFocusColor,
  );

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      typography: Typography(
        white: LightTheme.lightTextTheme,
        black: DarkTheme.darkTextTheme,
      ),
      textTheme: colorScheme.brightness == Brightness.light
          ? LightTheme.lightTextTheme
          : DarkTheme.darkTextTheme,
      appBarTheme: colorScheme.brightness == Brightness.light
          ? LightTheme.lightAppBarTheme
          : DarkTheme.darkAppBarTheme,
      inputDecorationTheme: colorScheme.brightness == Brightness.light
          ? LightTheme.lightInputDecorationTheme
          : DarkTheme.darkInputDecorationTheme,
      bottomNavigationBarTheme: colorScheme.brightness == Brightness.light
          ? LightTheme.lightBottomNavigationBarTheme
          : DarkTheme.darkBottomNavigationBarTheme,
      dividerTheme: colorScheme.brightness == Brightness.light
          ? LightTheme.lightDividerTheme
          : DarkTheme.darkDividerTheme,
    );
  }

  static ThemeEnum getThemeEnum(String theme) {
    switch (theme) {
      case 'Light':
        return ThemeEnum.light;
      case 'Dark':
        return ThemeEnum.dark;
      case 'System':
        return ThemeEnum.system;
      default:
        return ThemeEnum.light;
    }
  }
}
