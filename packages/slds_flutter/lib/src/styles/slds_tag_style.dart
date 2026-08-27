import 'package:flutter/widgets.dart';

/// Visual style overrides for SldsTag. Null fields inherit from [SldsTokenSet].
class SldsTagStyle {
  final Color? backgroundColor;

  final Color? foregroundColor;

  final double? borderRadius;

  final EdgeInsetsGeometry? padding;

  final TextStyle? textStyle;

  const SldsTagStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.padding,
    this.textStyle,
  });

  SldsTagStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
  }) {
    return SldsTagStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}
