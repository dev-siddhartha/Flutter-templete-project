import 'package:flutter/widgets.dart';

/// Visual style overrides for SldsProgressBar. Null fields inherit from [SldsTokenSet].
class SldsProgressBarStyle {
  final Color? fillColor;

  final Color? trackColor;

  final double? segmentHeight;

  final TextStyle? labelStyle;

  const SldsProgressBarStyle({
    this.fillColor,
    this.trackColor,
    this.segmentHeight,
    this.labelStyle,
  });

  SldsProgressBarStyle copyWith({
    Color? fillColor,
    Color? trackColor,
    double? segmentHeight,
    TextStyle? labelStyle,
  }) {
    return SldsProgressBarStyle(
      fillColor: fillColor ?? this.fillColor,
      trackColor: trackColor ?? this.trackColor,
      segmentHeight: segmentHeight ?? this.segmentHeight,
      labelStyle: labelStyle ?? this.labelStyle,
    );
  }
}

/// Visual style overrides for SldsStepper. Null fields inherit from [SldsTokenSet].
class SldsStepperStyle {
  final Color? activeColor;

  final Color? inactiveColor;

  final double? segmentHeight;

  const SldsStepperStyle({
    this.activeColor,
    this.inactiveColor,
    this.segmentHeight,
  });

  SldsStepperStyle copyWith({
    Color? activeColor,
    Color? inactiveColor,
    double? segmentHeight,
  }) {
    return SldsStepperStyle(
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      segmentHeight: segmentHeight ?? this.segmentHeight,
    );
  }
}
