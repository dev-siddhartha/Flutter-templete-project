import 'package:flutter/widgets.dart';

/// Visual style overrides for SldsButton. Null fields inherit from [SldsTokenSet].
class SldsButtonStyle {
  final Color? backgroundColor;

  final Color? foregroundColor;

  final Color? borderColor;

  final double? borderRadius;

  final EdgeInsetsGeometry? padding;

  final TextStyle? textStyle;

  const SldsButtonStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.textStyle,
  });

  SldsButtonStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
  }) {
    return SldsButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}
