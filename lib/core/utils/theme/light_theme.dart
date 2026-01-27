import 'package:flutter_template/core/constants/app_constants.dart';
import 'package:flutter_template/core/utils/app_imports.dart';

class LightTheme {
  static final Color lightFocusColor = Colors.black.withValues(alpha: 0.12);

  static ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary[500],
    onPrimary: AppColors.whiteColor,
    secondary: AppColors.secondary[500],
    onSecondary: AppColors.whiteColor,
    tertiary: AppColors.info[500],
    onTertiary: AppColors.whiteColor,
    error: AppColors.error[500],
    onError: AppColors.whiteColor,
    surface: AppColors.lightSurface,
    onSurface: AppColors.lightTextPrimary,
    onSurfaceVariant: AppColors.lightTextSecondary,
    outline: AppColors.grey[300],
    outlineVariant: AppColors.grey[200],
    shadow: AppColors.blackColor.withAlpha(100),
    scrim: AppColors.blackColor.withAlpha(128),
    inverseSurface: AppColors.darkSurface,
    onInverseSurface: AppColors.darkTextPrimary,
    inversePrimary: AppColors.primary[300],
  );

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 34.sp,
      letterSpacing: 0.2,
      color: AppColors.lightTextPrimary,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 32.sp,
      color: AppColors.lightTextPrimary,
      letterSpacing: 0.2,
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 30.sp,
      color: AppColors.lightTextPrimary,
      letterSpacing: 0.2,
    ),
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 28.sp,
      color: AppColors.lightTextPrimary,
      letterSpacing: .2,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 26.sp,
      color: AppColors.lightTextPrimary,
      letterSpacing: 0.2,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 24.sp,
      color: AppColors.lightTextPrimary,
      letterSpacing: 0.2,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 22.sp,
      color: AppColors.lightTextPrimary,
      letterSpacing: 0.2,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20.sp,
      color: AppColors.lightTextPrimary,
      letterSpacing: 0.2,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 18.sp,
      color: AppColors.lightTextPrimary,
      letterSpacing: 0.2,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16.sp,
      color: AppColors.lightTextPrimary,
      letterSpacing: 0.2,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      color: AppColors.lightTextPrimary,
      letterSpacing: 0.2,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      color: AppColors.lightTextSecondary,
      letterSpacing: 0.2,
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      color: AppColors.lightTextPrimary,
      letterSpacing: 0.2,
    ),
    labelMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
      color: AppColors.lightTextSecondary,
      letterSpacing: 0.2,
    ),
    labelSmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 11.sp,
      color: AppColors.lightTextTertiary,
      letterSpacing: 0.2,
    ),
  );

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    suffixIconColor: AppColors.lightTextSecondary,
    prefixIconColor: AppColors.lightTextSecondary,
    border: globalBorder(color: AppColors.grey[300]),
    errorBorder: globalBorder(color: AppColors.error[500]),
    focusedBorder: globalBorder(color: AppColors.primary[500]),
    enabledBorder: globalBorder(color: AppColors.grey[300]),
    disabledBorder: globalBorder(color: AppColors.grey[200]),
    focusedErrorBorder: globalBorder(color: AppColors.error[500]),
    errorStyle: TextStyle(color: AppColors.error[500]),
    hintStyle: TextStyle(
      color: AppColors.lightTextTertiary,
    ),
    labelStyle: TextStyle(color: AppColors.lightTextSecondary),
    helperStyle: TextStyle(color: AppColors.lightTextTertiary),
    fillColor: AppColors.lightSurface,
    filled: false,
  );

  static AppBarTheme lightAppBarTheme = AppBarTheme(
    backgroundColor: AppColors.lightSurface,
    foregroundColor: AppColors.lightTextPrimary,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.lightTextPrimary),
    actionsIconTheme: IconThemeData(color: AppColors.lightTextPrimary),
    titleTextStyle: TextStyle(
      color: AppColors.lightTextPrimary,
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
    ),
  );

  static BottomAppBarTheme lightBottomAppBarTheme = BottomAppBarTheme(
    color: AppColors.lightSurface,
    elevation: 0,
  );

  static BottomNavigationBarThemeData lightBottomNavigationBarTheme =
      BottomNavigationBarThemeData(
    backgroundColor: AppColors.lightSurface,
    selectedItemColor: AppColors.primary[500],
    unselectedItemColor: AppColors.lightTextSecondary,
    selectedIconTheme: IconThemeData(color: AppColors.primary[500]),
    unselectedIconTheme: IconThemeData(color: AppColors.lightTextSecondary),
    selectedLabelStyle: TextStyle(color: AppColors.primary[500]),
    unselectedLabelStyle: TextStyle(color: AppColors.lightTextSecondary),
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  );

  static DividerThemeData lightDividerTheme = DividerThemeData(
    color: AppColors.grey[200],
    thickness: 0.5,
    space: 1,
  );

  static CardTheme lightCardTheme = CardTheme(
    color: AppColors.lightSurface,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: AppColors.grey[200], width: 1),
    ),
  );

  static DialogTheme lightDialogTheme = DialogTheme(
    backgroundColor: AppColors.lightSurface,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: TextStyle(
      color: AppColors.lightTextPrimary,
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
    ),
    contentTextStyle: TextStyle(
      color: AppColors.lightTextSecondary,
      fontSize: 14.sp,
    ),
  );
}
