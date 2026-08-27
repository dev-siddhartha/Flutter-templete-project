import 'package:flutter/widgets.dart';

/// Visual style overrides for SldsInput. Null fields inherit from [SldsTokenSet].
class SldsInputStyle {
  final Color? backgroundColor;

  final Color? borderColor;

  final Color? focusBorderColor;

  final Color? errorBorderColor;

  final Color? disabledBorderColor;

  final double? borderRadius;

  final EdgeInsetsGeometry? contentPadding;

  final TextStyle? labelStyle;

  final TextStyle? inputStyle;

  final TextStyle? hintStyle;

  final TextStyle? helperStyle;

  final TextStyle? errorStyle;

  final Color? iconColor;

  final Color? labelColor;

  const SldsInputStyle({
    this.backgroundColor,
    this.borderColor,
    this.focusBorderColor,
    this.errorBorderColor,
    this.disabledBorderColor,
    this.borderRadius,
    this.contentPadding,
    this.labelStyle,
    this.inputStyle,
    this.hintStyle,
    this.helperStyle,
    this.errorStyle,
    this.iconColor,
    this.labelColor,
  });

  SldsInputStyle copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? focusBorderColor,
    Color? errorBorderColor,
    Color? disabledBorderColor,
    double? borderRadius,
    EdgeInsetsGeometry? contentPadding,
    TextStyle? labelStyle,
    TextStyle? inputStyle,
    TextStyle? hintStyle,
    TextStyle? helperStyle,
    TextStyle? errorStyle,
    Color? iconColor,
    Color? labelColor,
  }) {
    return SldsInputStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      focusBorderColor: focusBorderColor ?? this.focusBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      contentPadding: contentPadding ?? this.contentPadding,
      labelStyle: labelStyle ?? this.labelStyle,
      inputStyle: inputStyle ?? this.inputStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      helperStyle: helperStyle ?? this.helperStyle,
      errorStyle: errorStyle ?? this.errorStyle,
      iconColor: iconColor ?? this.iconColor,
      labelColor: labelColor ?? this.labelColor,
    );
  }
}
