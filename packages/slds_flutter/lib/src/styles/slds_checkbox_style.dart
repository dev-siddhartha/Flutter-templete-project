import 'package:flutter/widgets.dart';

/// Visual style overrides for SldsCheckbox. Null fields inherit from [SldsTokenSet].
class SldsCheckboxStyle {
  final Color? activeColor;

  final Color? inactiveColor;

  final Color? checkmarkColor;

  final double? borderRadius;

  final TextStyle? labelStyle;

  const SldsCheckboxStyle({
    this.activeColor,
    this.inactiveColor,
    this.checkmarkColor,
    this.borderRadius,
    this.labelStyle,
  });

  SldsCheckboxStyle copyWith({
    Color? activeColor,
    Color? inactiveColor,
    Color? checkmarkColor,
    double? borderRadius,
    TextStyle? labelStyle,
  }) {
    return SldsCheckboxStyle(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      checkmarkColor: checkmarkColor ?? this.checkmarkColor,
      borderRadius: borderRadius ?? this.borderRadius,
      labelStyle: labelStyle ?? this.labelStyle,
    );
  }
}
