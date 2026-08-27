import 'package:flutter/widgets.dart';

/// Visual style overrides for SldsTabBar. Null fields inherit from [SldsTokenSet].
class SldsTabBarStyle {
  final Color? backgroundColor;

  final Color? activeTabColor;

  final Color? inactiveTabColor;

  final Color? indicatorColor;

  final TextStyle? labelStyle;

  final Color? badgeBackgroundColor;

  final Color? badgeTextColor;

  const SldsTabBarStyle({
    this.backgroundColor,
    this.activeTabColor,
    this.inactiveTabColor,
    this.indicatorColor,
    this.labelStyle,
    this.badgeBackgroundColor,
    this.badgeTextColor,
  });

  SldsTabBarStyle copyWith({
    Color? backgroundColor,
    Color? activeTabColor,
    Color? inactiveTabColor,
    Color? indicatorColor,
    TextStyle? labelStyle,
    Color? badgeBackgroundColor,
    Color? badgeTextColor,
  }) {
    return SldsTabBarStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeTabColor: activeTabColor ?? this.activeTabColor,
      inactiveTabColor: inactiveTabColor ?? this.inactiveTabColor,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      labelStyle: labelStyle ?? this.labelStyle,
      badgeBackgroundColor: badgeBackgroundColor ?? this.badgeBackgroundColor,
      badgeTextColor: badgeTextColor ?? this.badgeTextColor,
    );
  }
}
