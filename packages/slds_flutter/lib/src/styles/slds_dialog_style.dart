import 'package:flutter/widgets.dart';

/// Visual style overrides for SldsDialog. Null fields inherit from [SldsTokenSet].
class SldsDialogStyle {
  final Color? backgroundColor;

  final Color? borderColor;

  final double? borderRadius;

  final EdgeInsetsGeometry? padding;

  final TextStyle? titleStyle;

  final TextStyle? messageStyle;

  const SldsDialogStyle({
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.titleStyle,
    this.messageStyle,
  });

  SldsDialogStyle copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
  }) {
    return SldsDialogStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      titleStyle: titleStyle ?? this.titleStyle,
      messageStyle: messageStyle ?? this.messageStyle,
    );
  }
}
