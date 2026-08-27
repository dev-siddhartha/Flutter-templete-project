import 'package:flutter/widgets.dart';

/// Visual style overrides for SldsToggle. Null fields inherit from [SldsTokenSet].
class SldsToggleStyle {
  final Color? activeTrackColor;

  final Color? inactiveTrackColor;

  final Color? thumbColor;

  final Color? inactiveThumbColor;

  const SldsToggleStyle({
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
    this.inactiveThumbColor,
  });

  SldsToggleStyle copyWith({
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? thumbColor,
    Color? inactiveThumbColor,
  }) {
    return SldsToggleStyle(
      activeTrackColor: activeTrackColor ?? this.activeTrackColor,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      thumbColor: thumbColor ?? this.thumbColor,
      inactiveThumbColor: inactiveThumbColor ?? this.inactiveThumbColor,
    );
  }
}
