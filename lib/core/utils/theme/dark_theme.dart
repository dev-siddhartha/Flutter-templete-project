import 'package:flutter_template/core/constants/app_constants.dart';
import 'package:flutter_template/core/utils/app_imports.dart';

class DarkTheme {
  static final Color darkFocusColor = Colors.white.withValues(alpha: 0.12);

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromARGB(255, 7, 7, 7),
    onPrimary: Color.fromARGB(255, 7, 7, 7),
    secondary: AppColors.secondaryColorDark,
    onSecondary: AppColors.secondaryColorDark,
    error: AppColors.errorColorDark,
    onError: AppColors.errorColorDark,
    surface: Color.fromARGB(255, 44, 43, 50),
    onSurface: Color.fromARGB(255, 57, 57, 57),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      fontWeight: FontWeight.w500,
      fontSize: 28.sp,
      letterSpacing: 0.2,
      color: AppColors.txtDisplayColorDark,
    ),
    displayMedium: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      fontWeight: FontWeight.w500,
      fontSize: 24.sp,
      color: AppColors.txtDisplayColorDark,
      letterSpacing: 0.2,
    ),
    displaySmall: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      fontWeight: FontWeight.w500,
      fontSize: 22.sp,
      color: AppColors.txtDisplayColorDark,
      letterSpacing: 0.2,
    ),
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
      fontSize: 16.sp,
      color: AppColors.txtDisplayColorDark,
    ),
    headlineMedium: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
      fontSize: 14.sp,
      color: AppColors.txtDisplayColorDark,
    ),
    headlineSmall: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
      color: AppColors.txtDisplayColorDark,
    ),
    titleLarge: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w500,
      fontSize: 18.sp,
      color: AppColors.txtTitleColorDark,
    ),
    titleMedium: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      color: AppColors.txtTitleColorDark,
    ),
    titleSmall: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      color: AppColors.txtTitleColorDark,
    ),
    bodyLarge: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.2,
      fontSize: 16.sp,
      color: AppColors.txtBodyColorDark,
    ),
    bodyMedium: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      color: AppColors.txtBodyColorDark,
    ),
    bodySmall: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.2,
      fontSize: 12.sp,
      color: AppColors.txtBodyColorDark,
    ),
  );
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    hintStyle: const TextStyle(color: AppColors.greyColor),
    labelStyle: const TextStyle(color: AppColors.txtBodyColorDark),
    errorStyle: const TextStyle(color: AppColors.errorColorDark),
    suffixIconColor: AppColors.whiteColor,
    errorBorder: globalBorder(color: AppColors.errorColorDark),
    focusedErrorBorder: globalBorder(color: AppColors.errorColorDark),
    focusedBorder: globalBorder(color: AppColors.borderColorDark),
    enabledBorder: globalBorder(color: AppColors.borderColorDark),
    disabledBorder: globalBorder(color: AppColors.borderColorDark),
    border: globalBorder(color: AppColors.borderColorDark),
  );

  static AppBarTheme darkAppBarTheme = const AppBarTheme(
    backgroundColor: AppColors.scaffoldBgColorDark,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.iconColor),
    actionsIconTheme: IconThemeData(color: AppColors.iconColor),
  );

  static BottomAppBarTheme darkBottomAppBarTheme = const BottomAppBarTheme(
    color: AppColors.scaffoldBgColorDark,
  );

  static BottomNavigationBarThemeData darkBottomNavigationBarTheme =
      const BottomNavigationBarThemeData(
    backgroundColor: AppColors.scaffoldBgColorDark,
    selectedItemColor: AppColors.primaryColorLight,
    unselectedItemColor: AppColors.txtBodyColorDark,
  );
}
