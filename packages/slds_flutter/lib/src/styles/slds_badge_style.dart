import 'package:flutter/widgets.dart';

/// Visual style overrides for SldsBadge. Null fields inherit from [SldsTokenSet].
class SldsBadgeStyle {
  final Color? backgroundColor;

  final Color? foregroundColor;

  final double? borderRadius;

  final EdgeInsetsGeometry? padding;

  final TextStyle? textStyle;

  const SldsBadgeStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.padding,
    this.textStyle,
  });

  SldsBadgeStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
  }) {
    return SldsBadgeStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}
