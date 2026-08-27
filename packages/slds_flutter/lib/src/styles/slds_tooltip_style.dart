import 'package:flutter/widgets.dart';

/// Visual style overrides for SldsTooltip. Null fields inherit from [SldsTokenSet].
class SldsTooltipStyle {
  final Color? backgroundColor;

  final Color? foregroundColor;

  final double? borderRadius;

  final EdgeInsetsGeometry? padding;

  final TextStyle? titleStyle;

  final TextStyle? descriptionStyle;

  const SldsTooltipStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.padding,
    this.titleStyle,
    this.descriptionStyle,
  });

  SldsTooltipStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
  }) {
    return SldsTooltipStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      titleStyle: titleStyle ?? this.titleStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
    );
  }
}
