import 'package:flutter/material.dart';

class CustomColorSwatch extends ColorSwatch<int> {
  const CustomColorSwatch(super.primary, super.swatch);

  @override
  Color operator [](int key) => super[key]!;

  Color call() => this[500];
}

class AppColors {
  AppColors._();

  /// LIGHT COLOR
  static const CustomColorSwatch primary = CustomColorSwatch(
    500,
    {
      50: Color(0xFFe6f9f5),
      100: Color(0xFFb0ebe1),
      200: Color(0xFF8ae2d3),
      300: Color(0xFF54d4bf),
      400: Color(0xFF33ccb2),
      500: Color(0xFF00bf9f),
      600: Color(0xFF00ae91),
      700: Color(0xFF008871),
      800: Color(0xFF006957),
      900: Color(0xFF005043),
    },
  );

  /// for now same code as primary
  static const CustomColorSwatch secondary = CustomColorSwatch(
    500,
    {
      50: Color(0xFFe6f9f5),
      100: Color(0xFFb0ebe1),
      200: Color(0xFF8ae2d3),
      300: Color(0xFF54d4bf),
      400: Color(0xFF33ccb2),
      500: Color(0xFF00bf9f),
      600: Color(0xFF00ae91),
      700: Color(0xFF008871),
      800: Color(0xFF006957),
      900: Color(0xFF005043),
    },
  );

  static const CustomColorSwatch success = CustomColorSwatch(
    500,
    {
      50: Color(0xFFe9f9ef),
      100: Color(0xFFbaedcd),
      200: Color(0xFF99e4b5),
      300: Color(0xFF6bd893),
      400: Color(0xFF4ed17e),
      500: Color(0xFF22c55e),
      600: Color(0xFF1fb356),
      700: Color(0xFF188c43),
      800: Color(0xFF136c34),
      900: Color(0xFF0e5327),
    },
  );

  static const CustomColorSwatch error = CustomColorSwatch(
    500,
    {
      50: Color(0xFFfbeae8),
      100: Color(0xFFf3beb8),
      200: Color(0xFFed9e95),
      300: Color(0xFFe57265),
      400: Color(0xFFe05647),
      500: Color(0xFFd82c19),
      600: Color(0xFFc52817),
      700: Color(0xFF991f12),
      800: Color(0xFF77180e),
      900: Color(0xFF5b120b),
    },
  );

  static const CustomColorSwatch grey = CustomColorSwatch(
    500,
    {
      50: Color(0xFFF6F7F8),
      100: Color(0xFFF8F9FA),
      200: Color(0xFFE9ECEF),
      300: Color(0xFFDEE2E6),
      400: Color(0xFFCED4DA),
      500: Color(0xFFADB5BD),
      600: Color(0xFF6C755D),
      700: Color(0xFF495057),
      800: Color(0xFF343A40),
      900: Color(0xFF212529),
    },
  );

  static const CustomColorSwatch warning = CustomColorSwatch(
    500,
    {
      50: Color(0xFFFFFFEA),
      100: Color(0xFFFFF3CD),
      200: Color(0xFFFFE69C),
      300: Color(0xFFFFDA6A),
      400: Color(0xFFFFCD39),
      500: Color(0xFFFFC107),
      600: Color(0xFFCC9A06),
      700: Color(0xFF997404),
      800: Color(0xFF664D03),
      900: Color(0xFF332701),
    },
  );

  static const CustomColorSwatch info = CustomColorSwatch(
    500,
    {
      50: Color(0xFFEDFFFC),
      100: Color(0xFFCFF4FC),
      200: Color(0xFF9EEAF9),
      300: Color(0xFF6EDFF6),
      400: Color(0xFF3DD5F3),
      500: Color(0xFF0DCAF0),
      600: Color(0xFF0AA2C0),
      700: Color(0xFF087990),
      800: Color(0xFF055160),
      900: Color(0xFF032830),
    },
  );

  /// dark theme colors (default)
  static Color primaryColor = primary[400]; // Lighter primary for dark theme
  static Color secondaryColor = secondary[400];
  static Color greyColor = grey[300]; // Lighter grey for dark theme
  static Color errorColor = error[400]; // Lighter error for dark theme
  static Color successColor = success[400]; // Lighter success for dark theme
  static Color warningColor = warning[400]; // Lighter warning for dark theme
  static Color infoColor = info[400]; // Lighter info for dark theme
  static Color blackColor = const Color(0xFF000000);
  static Color whiteColor = const Color(0xFFFFFFFF);

  // Light theme specific colors
  static Color lightSurface = whiteColor;
  static Color lightSurfaceVariant = grey[100];
  static Color lightTextPrimary = grey[900];
  static Color lightTextSecondary = grey[800];
  static Color lightTextTertiary = grey[700];

  // Dark theme specific colors
  static Color darkSurface = const Color.fromARGB(255, 2, 0, 6);
  static Color darkSurfaceVariant = grey[700];
  static Color darkTextPrimary = const Color(0xFFFFFFFF);
  static Color darkTextSecondary = const Color(0xFFB0B0B0);
  static Color darkTextTertiary = const Color(0xFF808080);
}
