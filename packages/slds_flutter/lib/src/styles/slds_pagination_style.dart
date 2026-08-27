import 'package:flutter/widgets.dart';

/// Visual style overrides for SldsPagination. Null fields inherit from [SldsTokenSet].
class SldsPaginationStyle {
  final Color? activeButtonColor;

  final Color? inactiveButtonColor;

  final Color? activeTextColor;

  final Color? inactiveTextColor;

  final TextStyle? labelStyle;

  final double? buttonSize;

  const SldsPaginationStyle({
    this.activeButtonColor,
    this.inactiveButtonColor,
    this.activeTextColor,
    this.inactiveTextColor,
    this.labelStyle,
    this.buttonSize,
  });

  SldsPaginationStyle copyWith({
    Color? activeButtonColor,
    Color? inactiveButtonColor,
    Color? activeTextColor,
    Color? inactiveTextColor,
    TextStyle? labelStyle,
    double? buttonSize,
  }) {
    return SldsPaginationStyle(
      activeButtonColor: activeButtonColor ?? this.activeButtonColor,
      inactiveButtonColor: inactiveButtonColor ?? this.inactiveButtonColor,
      activeTextColor: activeTextColor ?? this.activeTextColor,
      inactiveTextColor: inactiveTextColor ?? this.inactiveTextColor,
      labelStyle: labelStyle ?? this.labelStyle,
      buttonSize: buttonSize ?? this.buttonSize,
    );
  }
}
