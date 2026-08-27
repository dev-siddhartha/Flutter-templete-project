import 'package:flutter/widgets.dart';

/// Visual style overrides for SldsCard. Null fields inherit from [SldsTokenSet].
class SldsCardStyle {
  final Color? backgroundColor;

  final Color? borderColor;

  final double? borderRadius;

  final EdgeInsetsGeometry? padding;

  final double? imageHeight;

  /// Optional background gradient. Takes precedence over [backgroundColor]
  /// when set.
  final Gradient? gradient;

  /// Defaults to [BoxShape.rectangle]. When [BoxShape.circle], [borderRadius]
  /// is ignored (a circle can't also have a corner radius).
  final BoxShape? shape;

  const SldsCardStyle({
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.imageHeight,
    this.gradient,
    this.shape,
  });

  SldsCardStyle copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    double? imageHeight,
    Gradient? gradient,
    BoxShape? shape,
  }) {
    return SldsCardStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      imageHeight: imageHeight ?? this.imageHeight,
      gradient: gradient ?? this.gradient,
      shape: shape ?? this.shape,
    );
  }
}
