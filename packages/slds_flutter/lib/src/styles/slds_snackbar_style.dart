import 'package:flutter/widgets.dart';

/// Visual style overrides for SldsSnackbar. Null fields inherit from [SldsTokenSet].
class SldsSnackbarStyle {
  final Color? backgroundColor;

  final Color? borderColor;

  final double? borderRadius;

  final EdgeInsetsGeometry? padding;

  final TextStyle? titleStyle;

  final TextStyle? descriptionStyle;

  final Color? dismissIconColor;

  const SldsSnackbarStyle({
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.titleStyle,
    this.descriptionStyle,
    this.dismissIconColor,
  });

  SldsSnackbarStyle copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    Color? dismissIconColor,
  }) {
    return SldsSnackbarStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      titleStyle: titleStyle ?? this.titleStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      dismissIconColor: dismissIconColor ?? this.dismissIconColor,
    );
  }
}
