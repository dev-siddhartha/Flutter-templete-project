import 'package:flutter/widgets.dart';

/// Visual style overrides for SldsChip. Null fields inherit from [SldsTokenSet].
class SldsChipStyle {
  final Color? backgroundColor;

  final Color? foregroundColor;

  final Color? borderColor;

  final double? borderRadius;

  final EdgeInsetsGeometry? padding;

  final TextStyle? textStyle;

  const SldsChipStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.textStyle,
  });

  SldsChipStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
  }) {
    return SldsChipStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}
