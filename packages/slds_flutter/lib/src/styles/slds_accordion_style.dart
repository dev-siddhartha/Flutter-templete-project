import 'package:flutter/widgets.dart';

/// Visual style overrides for SldsAccordion. Null fields inherit from [SldsTokenSet].
class SldsAccordionStyle {
  final Color? headerBackgroundColor;

  final Color? contentBackgroundColor;

  final Color? borderColor;

  final double? borderRadius;

  final EdgeInsetsGeometry? headerPadding;

  final EdgeInsetsGeometry? contentPadding;

  final TextStyle? titleStyle;

  const SldsAccordionStyle({
    this.headerBackgroundColor,
    this.contentBackgroundColor,
    this.borderColor,
    this.borderRadius,
    this.headerPadding,
    this.contentPadding,
    this.titleStyle,
  });

  SldsAccordionStyle copyWith({
    Color? headerBackgroundColor,
    Color? contentBackgroundColor,
    Color? borderColor,
    double? borderRadius,
    EdgeInsetsGeometry? headerPadding,
    EdgeInsetsGeometry? contentPadding,
    TextStyle? titleStyle,
  }) {
    return SldsAccordionStyle(
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      contentBackgroundColor:
          contentBackgroundColor ?? this.contentBackgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      headerPadding: headerPadding ?? this.headerPadding,
      contentPadding: contentPadding ?? this.contentPadding,
      titleStyle: titleStyle ?? this.titleStyle,
    );
  }
}
