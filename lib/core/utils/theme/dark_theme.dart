import 'package:flutter_template/core/constants/app_constants.dart';
import 'package:flutter_template/core/utils/app_imports.dart';

class DarkTheme {
  static final Color darkFocusColor = Colors.white.withValues(alpha: 0.12);

  static ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary[500],
    onPrimary: AppColors.darkTextPrimary,
    secondary: AppColors.secondary[500],
    onSecondary: AppColors.darkTextPrimary,
    tertiary: AppColors.info[500],
    onTertiary: AppColors.darkTextPrimary,
    error: AppColors.error[500],
    onError: AppColors.darkTextPrimary,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkTextPrimary,
    onSurfaceVariant: AppColors.darkTextSecondary,
    outline: AppColors.grey[600],
    outlineVariant: AppColors.grey[700],
    shadow: AppColors.blackColor,
    scrim: AppColors.blackColor.withAlpha(128),
    inverseSurface: AppColors.lightSurface,
    onInverseSurface: AppColors.lightTextPrimary,
    inversePrimary: AppColors.primary[600],
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 34.sp,
      letterSpacing: 0.2,
      color: AppColors.darkTextPrimary,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 32.sp,
      color: AppColors.darkTextPrimary,
      letterSpacing: 0.2,
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 30.sp,
      color: AppColors.darkTextPrimary,
      letterSpacing: 0.2,
    ),
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 28.sp,
      color: AppColors.darkTextPrimary,
      letterSpacing: .2,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 26.sp,
      color: AppColors.darkTextPrimary,
      letterSpacing: 0.2,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 24.sp,
      color: AppColors.darkTextPrimary,
      letterSpacing: 0.2,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 22.sp,
      color: AppColors.darkTextPrimary,
      letterSpacing: 0.2,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20.sp,
      color: AppColors.darkTextPrimary,
      letterSpacing: 0.2,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 18.sp,
      color: AppColors.darkTextPrimary,
      letterSpacing: 0.2,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16.sp,
      color: AppColors.darkTextPrimary,
      letterSpacing: 0.2,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      color: AppColors.darkTextPrimary,
      letterSpacing: 0.2,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      color: AppColors.darkTextSecondary,
      letterSpacing: 0.2,
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      color: AppColors.darkTextPrimary,
      letterSpacing: 0.2,
    ),
    labelMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
      color: AppColors.darkTextSecondary,
      letterSpacing: 0.2,
    ),
    labelSmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 11.sp,
      color: AppColors.darkTextTertiary,
      letterSpacing: 0.2,
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    suffixIconColor: AppColors.darkTextSecondary,
    prefixIconColor: AppColors.darkTextSecondary,
    border: globalBorder(color: AppColors.darkSurfaceVariant),
    errorBorder: globalBorder(color: AppColors.error[400]),
    focusedBorder: globalBorder(color: AppColors.primary[400]),
    enabledBorder: globalBorder(color: AppColors.darkSurfaceVariant),
    disabledBorder: globalBorder(color: AppColors.grey[800]),
    focusedErrorBorder: globalBorder(color: AppColors.error[400]),
    errorStyle: TextStyle(color: AppColors.error[400]),
    hintStyle: TextStyle(
      color: AppColors.darkTextTertiary,
    ),
    labelStyle: TextStyle(color: AppColors.darkTextSecondary),
    helperStyle: TextStyle(color: AppColors.darkTextTertiary),
    fillColor: AppColors.darkSurfaceVariant,
    filled: false,
  );

  static AppBarTheme darkAppBarTheme = AppBarTheme(
    backgroundColor: AppColors.darkSurface,
    foregroundColor: AppColors.darkTextPrimary,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.darkTextPrimary),
    actionsIconTheme: IconThemeData(color: AppColors.darkTextPrimary),
    titleTextStyle: TextStyle(
      color: AppColors.darkTextPrimary,
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
    ),
  );

  static BottomAppBarTheme darkBottomAppBarTheme = BottomAppBarTheme(
    color: AppColors.darkSurface,
    elevation: 0,
  );

  static BottomNavigationBarThemeData darkBottomNavigationBarTheme =
      BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkSurface,
    selectedItemColor: AppColors.primary[400],
    unselectedItemColor: AppColors.darkTextSecondary,
    selectedIconTheme: IconThemeData(color: AppColors.primary[400]),
    unselectedIconTheme: IconThemeData(color: AppColors.darkTextSecondary),
    selectedLabelStyle: TextStyle(color: AppColors.primary[400]),
    unselectedLabelStyle: TextStyle(color: AppColors.darkTextSecondary),
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  );

  static DividerThemeData darkDividerTheme = DividerThemeData(
    color: AppColors.darkSurfaceVariant,
    thickness: 0.5,
    space: 1,
  );

  static CardTheme darkCardTheme = CardTheme(
    color: AppColors.darkSurfaceVariant,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );

  static DialogTheme darkDialogTheme = DialogTheme(
    backgroundColor: AppColors.darkSurface,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: TextStyle(
      color: AppColors.darkTextPrimary,
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
    ),
    contentTextStyle: TextStyle(
      color: AppColors.darkTextSecondary,
      fontSize: 14.sp,
    ),
  );
}
