import 'package:flutter_template/core/constants/app_constants.dart';
import 'package:flutter_template/core/utils/app_imports.dart';

class LightTheme {
  static final Color lightFocusColor = Colors.black.withValues(alpha: 0.12);

  static ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryColor,
    onPrimary: AppColors.primaryColor,
    secondary: AppColors.secondaryColor,
    onSecondary: AppColors.secondaryColor,
    error: AppColors.errorColor,
    onError: AppColors.errorColor,
    surface: AppColors.whiteColor,
    onSurface: AppColors.whiteColor,
  );

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 28.sp,
      letterSpacing: 0.2,
      color: AppColors.grey[900],
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 24.sp,
      color: AppColors.grey[900],
      letterSpacing: 0.2,
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 22.sp,
      color: AppColors.grey[900],
      letterSpacing: 0.2,
    ),
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w500,
      letterSpacing: .2,
      fontSize: 16.sp,
      color: AppColors.grey[900],
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
      fontSize: 14.sp,
      color: AppColors.grey[900],
    ),
    headlineSmall: TextStyle(
      letterSpacing: 0.2,
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
      color: AppColors.grey[900],
    ),
    titleLarge: TextStyle(
      letterSpacing: 0.2,
      fontWeight: FontWeight.w500,
      fontSize: 18.sp,
      color: AppColors.grey[900],
    ),
    titleMedium: TextStyle(
      letterSpacing: 0.2,
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      color: AppColors.grey[900],
    ),
    titleSmall: TextStyle(
      letterSpacing: 0.2,
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      color: AppColors.grey[900],
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w400,
      letterSpacing: 0.2,
      fontSize: 16.sp,
      color: AppColors.grey[900],
    ),
    bodyMedium: TextStyle(
      letterSpacing: 0.2,
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      color: AppColors.grey[900],
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      letterSpacing: 0.2,
      fontSize: 12.sp,
      color: AppColors.grey[900],
    ),
  );

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    suffixIconColor: AppColors.blackColor,
    border: globalBorder(color: AppColors.grey[100]),
    errorBorder: globalBorder(color: AppColors.error[400]),
    focusedBorder: globalBorder(color: AppColors.grey[100]),
    enabledBorder: globalBorder(color: AppColors.grey[100]),
    focusedErrorBorder: globalBorder(color: AppColors.error[400]),
    errorStyle: TextStyle(color: AppColors.error[400]),
    hintStyle: TextStyle(
      color: AppColors.grey[900],
    ),
    labelStyle: TextStyle(color: AppColors.grey[900]),
  );

  static AppBarTheme lightAppBarTheme = AppBarTheme(
    backgroundColor: AppColors.whiteColor,
    foregroundColor: AppColors.whiteColor,
    surfaceTintColor: AppColors.whiteColor,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.grey[700]),
    actionsIconTheme: IconThemeData(color: AppColors.grey[700]),
  );

  static BottomAppBarTheme lightBottomAppBarTheme = BottomAppBarTheme(
    color: AppColors.whiteColor,
    elevation: 0,
  );

  static BottomNavigationBarThemeData lightBottomNavigationBarTheme =
      BottomNavigationBarThemeData(
    backgroundColor: AppColors.whiteColor,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.grey[900],
  );
}
