import 'package:flutter_template/core/utils/app_imports.dart';

extension FontStyleExtension on BuildContext {
  TextStyle getFontStyle({
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
    FontStyle? fontStyle,
    double? letterSpacing = 0,
    double? wordSpacing,
    double? height,
    String? fontFamily = "Poppins",
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      height: height,
      decoration: decoration,
      wordSpacing: wordSpacing,
      fontFamily: fontFamily,
    );
  }
}

extension DarkMode on BuildContext {
  bool get isDark {
    if (Theme.of(this).brightness == Brightness.dark) {
      return true;
    } else {
      return false;
    }
  }
}

extension PrimaryColor on BuildContext {
  Color get primaryColor {
    return Theme.of(this).primaryColor;
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  String firstLetterCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String firstLetterEachWordCapitalized() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.firstLetterCapitalized())
      .join(' ');
}
