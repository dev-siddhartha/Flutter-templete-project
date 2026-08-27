import 'package:flutter/widgets.dart';

/// Visual style overrides for SldsRadio. Null fields inherit from [SldsTokenSet].
class SldsRadioStyle {
  final Color? activeColor;

  final Color? inactiveColor;

  final Color? dotColor;

  final TextStyle? labelStyle;

  const SldsRadioStyle({
    this.activeColor,
    this.inactiveColor,
    this.dotColor,
    this.labelStyle,
  });

  SldsRadioStyle copyWith({
    Color? activeColor,
    Color? inactiveColor,
    Color? dotColor,
    TextStyle? labelStyle,
  }) {
    return SldsRadioStyle(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      dotColor: dotColor ?? this.dotColor,
      labelStyle: labelStyle ?? this.labelStyle,
    );
  }
}
