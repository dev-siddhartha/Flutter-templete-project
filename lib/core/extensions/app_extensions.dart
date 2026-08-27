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

/// Entry point for SLDS palette-swatch access via `context.colors.*`.
///
/// Semantic (theme-aware) colors come from `context.slds.colors.*` instead —
/// this accessor is palette-only.
///
/// Usage:
/// ```dart
/// context.colors.primary[500]
/// context.colors.grey[100]
/// context.colors.error[600]
/// ```
extension SldsColorsEntryPoint on BuildContext {
  SldsColors get colors => SldsColors(SldsTheme.of(this));
}

/// Provides access to SLDS raw palette swatches only.
class SldsColors {
  const SldsColors(this._tokens);

  final SldsTokenSet _tokens;

  SldsColorSwatch get primary => _tokens.primary;
  SldsColorSwatch get secondary => _tokens.secondary;
  SldsColorSwatch get success => _tokens.success;
  SldsColorSwatch get error => _tokens.error;
  SldsColorSwatch get grey => _tokens.grey;
  SldsColorSwatch get warning => _tokens.warning;
  SldsColorSwatch get info => _tokens.info;
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
