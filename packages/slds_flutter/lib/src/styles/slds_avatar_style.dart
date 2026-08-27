import 'package:flutter/widgets.dart';

/// Visual style overrides for SldsAvatar. Null fields inherit from [SldsTokenSet].
class SldsAvatarStyle {
  final Color? backgroundColor;

  final Color? foregroundColor;

  final double? borderWidth;

  final Color? borderColor;

  final TextStyle? initialsStyle;

  const SldsAvatarStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.borderWidth,
    this.borderColor,
    this.initialsStyle,
  });

  SldsAvatarStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    double? borderWidth,
    Color? borderColor,
    TextStyle? initialsStyle,
  }) {
    return SldsAvatarStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderColor: borderColor ?? this.borderColor,
      initialsStyle: initialsStyle ?? this.initialsStyle,
    );
  }
}
