import 'package:flutter/widgets.dart';

/// Visual style overrides for SldsListItem. Null fields inherit from [SldsTokenSet].
class SldsListItemStyle {
  final Color? backgroundColor;

  final EdgeInsetsGeometry? padding;

  final TextStyle? titleStyle;

  final TextStyle? descriptionStyle;

  const SldsListItemStyle({
    this.backgroundColor,
    this.padding,
    this.titleStyle,
    this.descriptionStyle,
  });

  SldsListItemStyle copyWith({
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
  }) {
    return SldsListItemStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      padding: padding ?? this.padding,
      titleStyle: titleStyle ?? this.titleStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
    );
  }
}
