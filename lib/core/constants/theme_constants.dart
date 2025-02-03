import 'package:flutter_template/core/utils/app_imports.dart';

enum ThemeEnum { light, dark, system }

// Extension for ThemeEnum
extension ThemeEnumExtension on ThemeEnum {
  String toFormattedString() {
    return name.firstLetterCapitalized();
  }

  // Static method to convert a formatted string back to the enum
  static ThemeEnum fromFormattedString(String themeString) {
    String normalizedString = themeString.toLowerCase();
    return ThemeEnum.values.firstWhere(
      (e) => e.name.toLowerCase() == normalizedString,
      orElse: () => throw ArgumentError('Invalid theme string: $themeString'),
    );
  }
}
