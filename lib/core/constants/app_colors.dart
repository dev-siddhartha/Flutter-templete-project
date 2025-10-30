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
      50: Color(0xFFEFF6FF),
      100: Color(0xFFDBEAFE),
      200: Color(0xFFBFDBFE),
      300: Color(0xFF94C4FC),
      400: Color(0xFF508EF6),
      500: Color(0xFF1F3A8A),
      600: Color(0xFF192E6E),
      700: Color(0xFF101D45),
      800: Color(0xFF08142F),
      900: Color(0xFF040A17),
    },
  );

  /// for now almost the same code as primary
  static const CustomColorSwatch secondary = CustomColorSwatch(500, {
    50: Color(0xFFEFF6FF),
    100: Color(0xFFDBEAFE),
    200: Color(0xFFBFDBFE),
    300: Color(0xFF94C4FC),
    400: Color(0xFF508EF6),
    500: Color(0xFF10B981),
    600: Color(0xFF192E6E),
    700: Color(0xFF101D45),
    800: Color(0xFF08142F),
    900: Color(0xFF040A17),
  });

  static const CustomColorSwatch error = CustomColorSwatch(
    500,
    {
      50: Color(0xFFFEF2F2),
      100: Color(0xFFF8D7DA),
      200: Color(0xFFF1AEB5),
      300: Color(0xFFEA868F),
      400: Color(0xFFE35D6A),
      500: Color(0xFFDC3545),
      600: Color(0xFFB02A37),
      700: Color(0xFF842029),
      800: Color(0xFF58151C),
      900: Color(0xFF2C0B0E),
    },
  );

  static const CustomColorSwatch success = CustomColorSwatch(
    500,
    {
      50: Color(0xFFF1FCF5),
      100: Color(0xFFD1E7DD),
      200: Color(0xFFA3CFBB),
      300: Color(0xFF75B798),
      400: Color(0xFF479F76),
      500: Color(0xFF198754),
      600: Color(0xFF146C43),
      700: Color(0xFF0f5132),
      800: Color(0xFF0A3622),
      900: Color(0xFF051B11),
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

  /// light theme colors
  static Color primaryColor = primary[500];
  static Color secondaryColor = secondary[400];
  static Color greyColor = grey[600];
  static Color errorColor = error[500];
  static Color successColor = success[500];
  static Color warningColor = warning[500];
  static Color infoColor = info[500];
  static Color blackColor = Colors.black;
  static Color whiteColor = Colors.white;
}
