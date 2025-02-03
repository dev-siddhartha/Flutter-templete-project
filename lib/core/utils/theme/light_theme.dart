import 'package:flutter_template/core/constants/app_constants.dart';
import 'package:flutter_template/core/utils/app_imports.dart';

class LightTheme {
  static final Color lightFocusColor = Colors.black.withValues(alpha: 0.12);

  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryColorLight,
    onPrimary: AppColors.primaryColorLight,
    secondary: AppColors.secondaryColorLight,
    onSecondary: AppColors.secondaryColorLight,
    error: AppColors.errorColorLight,
    onError: AppColors.errorColorLight,
    surface: AppColors.scaffoldBgColorLight,
    onSurface: AppColors.scaffoldBgColorLight,
  );

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      fontWeight: FontWeight.w500,
      fontSize: 28.sp,
      letterSpacing: 0.2,
      color: AppColors.txtDisplayColorLight,
    ),
    displayMedium: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      fontWeight: FontWeight.w500,
      fontSize: 24.sp,
      color: AppColors.txtDisplayColorLight,
      letterSpacing: 0.2,
    ),
    displaySmall: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      fontWeight: FontWeight.w500,
      fontSize: 22.sp,
      color: AppColors.txtDisplayColorLight,
      letterSpacing: 0.2,
    ),
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w500,
      letterSpacing: .2,
      fontSize: 16.sp,
      color: AppColors.txtHeadlineColorLight,
    ),
    headlineMedium: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
      fontSize: 14.sp,
      color: AppColors.txtHeadlineColorLight,
    ),
    headlineSmall: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
      color: AppColors.txtHeadlineColorLight,
    ),
    titleLarge: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w500,
      fontSize: 18.sp,
      color: AppColors.txtTitleColorLight,
    ),
    titleMedium: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      color: AppColors.txtTitleColorLight,
    ),
    titleSmall: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      color: AppColors.txtTitleColorLight,
    ),
    bodyLarge: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.2,
      fontSize: 16.sp,
      color: AppColors.txtBodyColorLight,
    ),
    bodyMedium: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      color: AppColors.txtBodyColorLight,
    ),
    bodySmall: TextStyle(
      // fontFamily: ThemeFamilyConstant.poppins,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.2,
      fontSize: 12.sp,
      color: AppColors.txtBodyColorLight,
    ),
  );

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
      suffixIconColor: AppColors.blackColor,
      border: globalBorder(color: AppColors.borderColorLight),
      errorBorder: globalBorder(color: AppColors.errorColorLight),
      focusedBorder: globalBorder(color: AppColors.borderColorLight),
      enabledBorder: globalBorder(color: AppColors.borderColorLight),
      focusedErrorBorder: globalBorder(color: AppColors.errorColorLight),
      errorStyle: const TextStyle(color: AppColors.errorColorLight),
      hintStyle: const TextStyle(
        color: AppColors.txtBodyColorLight,
      ),
      labelStyle: const TextStyle(color: AppColors.txtBodyColorLight));

  static AppBarTheme lightAppBarTheme = const AppBarTheme(
    backgroundColor: AppColors.scaffoldBgColorLight,
    foregroundColor: AppColors.scaffoldBgColorLight,
    // shadowColor: AppColors.scaffoldBgColorLight,
    surfaceTintColor: AppColors.scaffoldBgColorLight,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.iconColor),
    actionsIconTheme: IconThemeData(color: AppColors.iconColor),
  );

  static BottomAppBarTheme lightBottomAppBarTheme = const BottomAppBarTheme(
    color: AppColors.scaffoldBgColorLight,
    elevation: 0,
  );

  static BottomNavigationBarThemeData lightBottomNavigationBarTheme =
      const BottomNavigationBarThemeData(
    backgroundColor: AppColors.scaffoldBgColorLight,
    selectedItemColor: AppColors.primaryColorLight,
    unselectedItemColor: AppColors.txtBodyColorLight,
  );
}
