import 'package:flutter/widgets.dart';

/// Visual style overrides for SldsNavigationDrawer. Null fields inherit from [SldsTokenSet].
class SldsNavigationDrawerStyle {
  final Color? backgroundColor;

  final Color? activeItemBackgroundColor;

  final Color? inactiveItemBackgroundColor;

  final Color? activeItemLabelColor;

  final Color? inactiveItemLabelColor;

  final EdgeInsetsGeometry? itemPadding;

  final TextStyle? titleStyle;

  final TextStyle? itemStyle;

  const SldsNavigationDrawerStyle({
    this.backgroundColor,
    this.activeItemBackgroundColor,
    this.inactiveItemBackgroundColor,
    this.activeItemLabelColor,
    this.inactiveItemLabelColor,
    this.itemPadding,
    this.titleStyle,
    this.itemStyle,
  });

  SldsNavigationDrawerStyle copyWith({
    Color? backgroundColor,
    Color? activeItemBackgroundColor,
    Color? inactiveItemBackgroundColor,
    Color? activeItemLabelColor,
    Color? inactiveItemLabelColor,
    EdgeInsetsGeometry? itemPadding,
    TextStyle? titleStyle,
    TextStyle? itemStyle,
  }) {
    return SldsNavigationDrawerStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeItemBackgroundColor:
          activeItemBackgroundColor ?? this.activeItemBackgroundColor,
      inactiveItemBackgroundColor:
          inactiveItemBackgroundColor ?? this.inactiveItemBackgroundColor,
      activeItemLabelColor: activeItemLabelColor ?? this.activeItemLabelColor,
      inactiveItemLabelColor:
          inactiveItemLabelColor ?? this.inactiveItemLabelColor,
      itemPadding: itemPadding ?? this.itemPadding,
      titleStyle: titleStyle ?? this.titleStyle,
      itemStyle: itemStyle ?? this.itemStyle,
    );
  }
}
