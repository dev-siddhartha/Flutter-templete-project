import 'package:flutter/material.dart';

import '../styles/slds_progress_style.dart';
import '../theme/slds_theme.dart';
import 'slds_focus.dart';
import 'slds_state.dart';

/// Figma-backed SLDS progress bar.
class SldsProgressBar extends StatelessWidget {
  /// Creates an SLDS progress bar.
  const SldsProgressBar({
    super.key,
    required this.value,
    this.showLabel = true,
    this.state,
    this.semanticLabel,
    this.width,
    this.style,
  }) : assert(value <= 100, "Value can't be bigger than 100");

  /// 0 to 100.
  final double value;

  final bool showLabel;

  final SldsComponentState? state;

  final String? semanticLabel;

  /// Optional fixed width. When null uses the token default (339 px).
  final double? width;

  /// Visual style overrides. Null fields inherit from the active [SldsTokenSet].
  final SldsProgressBarStyle? style;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final progressStyle = _ProgressStyle.resolve(context, state);
    final effectiveFill = style?.fillColor ?? progressStyle.fill;
    final effectiveTrack = style?.trackColor ?? progressStyle.track;
    final effectiveHeight =
        style?.segmentHeight ?? tokens.dimensions.progressSegmentHeight;

    final progressLabel =
        value.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0+$'), '');

    return Semantics(
      label: semanticLabel,
      value: '$progressLabel%',
      child: Container(
        width: width ?? tokens.dimensions.progressWidth,
        decoration: BoxDecoration(
          boxShadow:
              state == SldsComponentState.focus ? sldsFocusRing(tokens) : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                minHeight: effectiveHeight,
                value: value / 100,
                borderRadius: BorderRadius.circular(
                  tokens.dimensions.radiusFull,
                ),
                valueColor: AlwaysStoppedAnimation<Color>(effectiveFill),
                backgroundColor: effectiveTrack,
              ),
            ),
            if (showLabel) ...[
              SizedBox(width: tokens.dimensions.space12),
              Text(
                '$progressLabel%',
                style: style?.labelStyle ??
                    tokens.typography.body1
                        .copyWith(color: progressStyle.label),
                textAlign: TextAlign.right,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Figma step indicator with equal rounded segments.
class SldsStepper extends StatelessWidget {
  /// Creates an SLDS step indicator.
  const SldsStepper({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    this.state,
    this.semanticLabel,
    this.valueLabel,
    this.width,
    this.style,
  })  : assert(totalSteps > 0, 'totalSteps must be greater than 0.'),
        assert(currentStep >= 0, 'currentStep cannot be negative.'),
        assert(currentStep <= totalSteps,
            'currentStep cannot be greater than totalSteps.');

  final int totalSteps;

  final int currentStep;

  final SldsComponentState? state;

  final String? semanticLabel;

  /// Accessible semantic value, e.g. "3 of 6".
  /// Defaults to '$currentStep of $totalSteps' when null — pass your app's
  /// localized string.
  final String? valueLabel;

  /// Optional fixed width. When null uses the token default (393 px).
  final double? width;

  /// Visual style overrides. Null fields inherit from the active [SldsTokenSet].
  final SldsStepperStyle? style;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final progressStyle = _ProgressStyle.resolve(context, state);
    final effectiveFill = style?.activeColor ?? progressStyle.fill;
    final effectiveTrack = style?.inactiveColor ?? progressStyle.track;
    final effectiveHeight =
        style?.segmentHeight ?? tokens.dimensions.progressSegmentHeight;

    return Semantics(
      label: semanticLabel,
      value: valueLabel ?? '$currentStep of $totalSteps',
      child: Container(
        width: width ?? tokens.dimensions.stepperWidth,
        padding: EdgeInsets.symmetric(
          horizontal: tokens.dimensions.space16,
          vertical: tokens.dimensions.space4,
        ),
        decoration: BoxDecoration(
          boxShadow:
              state == SldsComponentState.focus ? sldsFocusRing(tokens) : null,
        ),
        child: Row(
          children: [
            for (var index = 0; index < totalSteps; index++) ...[
              if (index > 0) SizedBox(width: tokens.dimensions.space8),
              Expanded(
                child: AnimatedContainer(
                  duration: tokens.motion.normal,
                  height: effectiveHeight,
                  decoration: BoxDecoration(
                    color: index < currentStep ? effectiveFill : effectiveTrack,
                    borderRadius: BorderRadius.circular(
                      tokens.dimensions.radiusFull,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ProgressStyle {
  const _ProgressStyle({
    required this.fill,
    required this.track,
    required this.label,
  });

  final Color fill;
  final Color track;
  final Color label;

  static _ProgressStyle resolve(
      BuildContext context, SldsComponentState? state) {
    final c = context.slds.colors;
    switch (state) {
      case SldsComponentState.disabled:
        return _ProgressStyle(
          fill: c.disabledForeground,
          track: c.disabledBackground,
          label: c.disabledForeground,
        );
      case SldsComponentState.error:
        return _ProgressStyle(
            fill: c.error, track: c.badgeErrorBackground, label: c.error);
      case SldsComponentState.success:
        return _ProgressStyle(
            fill: c.success, track: c.badgeSuccessBackground, label: c.success);
      case SldsComponentState.loading:
        return _ProgressStyle(
          fill: c.warning,
          track: c.badgePendingBackground,
          label: c.warning,
        );
      case SldsComponentState.focus:
        return _ProgressStyle(
            fill: c.focusRing, track: c.surfaceHover, label: c.textPrimary);
      case SldsComponentState.active:
        return _ProgressStyle(
          fill: c.buttonPrimaryBackground,
          track: c.surfaceHover,
          label: c.textPrimary,
        );
      case SldsComponentState.hover:
      case SldsComponentState.empty:
        return _ProgressStyle(
            fill: c.info, track: c.surfaceHover, label: c.textSecondary);
      case SldsComponentState.defaultState:
      case null:
        return _ProgressStyle(
            fill: c.success, track: c.surfaceHover, label: c.textSecondary);
    }
  }
}
