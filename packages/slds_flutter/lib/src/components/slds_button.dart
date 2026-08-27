import 'dart:async';

import 'package:flutter/material.dart';

import '../styles/slds_button_style.dart';
import '../theme/slds_theme.dart';
import '../tokens/slds_tokens.dart';
import 'slds_focus.dart';
import 'slds_state.dart';

/// SLDS button variants from the Figma Action page.
enum SldsButtonVariant {
  /// Gold primary action.
  primary,

  /// Bordered secondary action.
  secondary,

  /// Transparent ghost action.
  ghost,

  /// Destructive action.
  destructive,
}

/// SLDS button sizes from the Figma Action page.
enum SldsButtonSize {
  /// 28px high.
  small,

  /// 36px high.
  medium,

  /// 48px high.
  large,

  /// 56px high.
  extraLarge,
}

/// Figma-backed SLDS button.
class SldsButton extends StatefulWidget {
  /// Creates an SLDS button.
  const SldsButton({
    super.key,
    required this.child,
    this.onPressed,
    this.variant = SldsButtonVariant.primary,
    this.size = SldsButtonSize.medium,
    this.state,
    this.leading,
    this.trailing,
    this.semanticLabel,
    this.width,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.style,
  });

  final Widget child;

  final VoidCallback? onPressed;

  final SldsButtonVariant variant;

  final SldsButtonSize size;

  /// Forced visual state, for docs and tests.
  final SldsComponentState? state;

  final Widget? leading;

  final Widget? trailing;

  /// Screen reader label.
  final String? semanticLabel;

  /// Optional fixed width. When null the button shrinks to content
  final double? width;

  /// Minimum gap between accepted taps before [onPressed] can fire again.
  /// Guards against accidental double-submits/double-navigation. Set to
  /// [Duration.zero] to disable.
  final Duration debounceDuration;

  /// Visual style overrides. Null fields inherit from the active [SldsTokenSet].
  final SldsButtonStyle? style;

  @override
  State<SldsButton> createState() => _SldsButtonState();
}

class _SldsButtonState extends State<SldsButton> {
  var _hovered = false;
  var _focused = false;
  var _pressed = false;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _handleTap() {
    if (widget.debounceDuration > Duration.zero) {
      if (_debounce?.isActive ?? false) return;
      _debounce = Timer(widget.debounceDuration, () {});
    }
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final state = widget.state ?? _interactiveState;
    final enabled = widget.onPressed != null && !sldsStateIsDisabled(state);
    final visual = _SldsButtonVisualStyle.resolve(
      tokens: tokens,
      variant: widget.variant,
      state: enabled ? state : SldsComponentState.disabled,
    );
    final btnStyle = widget.style;

    final height = _height(tokens, widget.size);
    final tapTargetHeight = height < tokens.dimensions.tapTargetMin
        ? tokens.dimensions.tapTargetMin
        : height;
    final radius = widget.size == SldsButtonSize.extraLarge
        ? tokens.dimensions.radius2xl
        : tokens.dimensions.radiusXl;
    final horizontalPadding = widget.size == SldsButtonSize.extraLarge
        ? tokens.dimensions.space16
        : tokens.dimensions.space8;
    final gap = widget.size == SldsButtonSize.extraLarge
        ? tokens.dimensions.space4
        : tokens.dimensions.space0;

    final baseTextStyle = widget.size == SldsButtonSize.extraLarge
        ? tokens.typography.title1
        : tokens.typography.body1;
    final effectiveFg = btnStyle?.foregroundColor ?? visual.foreground;
    final effectiveWidth = widget.width;

    return Semantics(
      button: true,
      enabled: enabled,
      label: widget.semanticLabel,
      child: FocusableActionDetector(
        enabled: enabled,
        includeFocusSemantics: false,
        mouseCursor:
            enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onShowHoverHighlight: (value) => setState(() => _hovered = value),
        onShowFocusHighlight: (value) => setState(() => _focused = value),
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              if (enabled) {
                _handleTap();
              }
              return null;
            },
          ),
        },
        child: GestureDetector(
          onTapDown: enabled ? (_) => setState(() => _pressed = true) : null,
          onTapCancel: enabled ? () => setState(() => _pressed = false) : null,
          onTapUp: enabled ? (_) => setState(() => _pressed = false) : null,
          onTap: enabled ? _handleTap : null,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: tapTargetHeight),
            child: Center(
              // Shrink-wrap idiom (size to child) — not a themable dimension.
              widthFactor: effectiveWidth == null ? 1.0 : null,
              heightFactor: 1.0,
              child: AnimatedContainer(
                duration: tokens.motion.fast,
                width: effectiveWidth,
                height: height,
                padding: btnStyle?.padding ??
                    EdgeInsets.symmetric(horizontal: horizontalPadding),
                decoration: BoxDecoration(
                  color: btnStyle?.backgroundColor ?? visual.background,
                  border: Border.all(
                    color: btnStyle?.borderColor ?? visual.border,
                    width: visual.borderWidth,
                  ),
                  borderRadius: BorderRadius.circular(
                    btnStyle?.borderRadius ?? radius,
                  ),
                  boxShadow: state == SldsComponentState.focus
                      ? sldsFocusRing(tokens)
                      : null,
                ),
                child: DefaultTextStyle.merge(
                  style: (btnStyle?.textStyle ?? baseTextStyle).copyWith(
                    color: effectiveFg,
                  ),
                  child: IconTheme.merge(
                    data: IconThemeData(color: effectiveFg),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state == SldsComponentState.loading)
                          SizedBox.square(
                            dimension: _iconSize(tokens, widget.size),
                            child: CircularProgressIndicator(
                              strokeWidth:
                                  tokens.dimensions.progressStrokeWidth,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                effectiveFg,
                              ),
                            ),
                          )
                        else if (widget.leading != null)
                          widget.leading!,
                        if (widget.leading != null ||
                            state == SldsComponentState.loading)
                          SizedBox(width: gap),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: tokens.dimensions.space6,
                          ),
                          child: widget.child,
                        ),
                        if (widget.trailing != null &&
                            state != SldsComponentState.loading)
                          SizedBox(width: gap),
                        if (widget.trailing != null &&
                            state != SldsComponentState.loading)
                          widget.trailing!,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SldsComponentState get _interactiveState {
    if (_pressed) {
      return SldsComponentState.active;
    }
    if (_focused) {
      return SldsComponentState.focus;
    }
    if (_hovered) {
      return SldsComponentState.hover;
    }
    return SldsComponentState.defaultState;
  }

  double _height(SldsTokenSet tokens, SldsButtonSize size) {
    switch (size) {
      case SldsButtonSize.small:
        return tokens.dimensions.buttonHeightSmall;
      case SldsButtonSize.medium:
        return tokens.dimensions.buttonHeightMedium;
      case SldsButtonSize.large:
        return tokens.dimensions.buttonHeightLarge;
      case SldsButtonSize.extraLarge:
        return tokens.dimensions.buttonHeightExtraLarge;
    }
  }

  double _iconSize(SldsTokenSet tokens, SldsButtonSize size) {
    switch (size) {
      case SldsButtonSize.small:
        return tokens.dimensions.space16;
      case SldsButtonSize.medium:
      case SldsButtonSize.large:
        return tokens.dimensions.space20;
      case SldsButtonSize.extraLarge:
        return tokens.dimensions.space24;
    }
  }
}

class _SldsButtonVisualStyle {
  const _SldsButtonVisualStyle({
    required this.background,
    required this.foreground,
    required this.border,
    required this.borderWidth,
  });

  final Color background;
  final Color foreground;
  final Color border;
  final double borderWidth;

  static _SldsButtonVisualStyle resolve({
    required SldsTokenSet tokens,
    required SldsButtonVariant variant,
    required SldsComponentState state,
  }) {
    final colors = tokens.colors;
    final borderWidth = tokens.dimensions.controlBorderWidth;

    if (state == SldsComponentState.disabled ||
        state == SldsComponentState.loading) {
      return _SldsButtonVisualStyle(
        background: colors.disabledBackground,
        foreground: colors.disabledForeground,
        border: colors.disabledBackground,
        borderWidth: borderWidth,
      );
    }

    if (state == SldsComponentState.error) {
      return _SldsButtonVisualStyle(
        background: colors.buttonDestructiveBackground,
        foreground: colors.buttonDestructiveLabel,
        border: colors.buttonDestructiveBackground,
        borderWidth: borderWidth,
      );
    }

    if (state == SldsComponentState.success) {
      return _SldsButtonVisualStyle(
        background: colors.success,
        foreground: colors.textPrimary,
        border: colors.success,
        borderWidth: borderWidth,
      );
    }

    if (state == SldsComponentState.empty) {
      return _SldsButtonVisualStyle(
        background: colors.surfacePage.withAlpha(
          tokens.dimensions.transparentAlpha,
        ),
        foreground: colors.textSecondary,
        border: colors.borderDefault,
        borderWidth: borderWidth,
      );
    }

    switch (variant) {
      case SldsButtonVariant.primary:
        return _SldsButtonVisualStyle(
          background: state == SldsComponentState.active
              ? colors.buttonPrimaryPressed
              : state == SldsComponentState.hover
                  ? colors.buttonPrimaryHover
                  : colors.buttonPrimaryBackground,
          foreground: colors.buttonPrimaryLabel,
          border: colors.buttonPrimaryBackground,
          borderWidth: borderWidth,
        );
      case SldsButtonVariant.secondary:
        return _SldsButtonVisualStyle(
          background: state == SldsComponentState.active
              ? colors.buttonSecondaryPressed
              : state == SldsComponentState.hover
                  ? colors.buttonSecondaryHover
                  : colors.buttonSecondaryBackground,
          foreground: colors.buttonSecondaryLabel,
          border: colors.buttonSecondaryBorder,
          borderWidth: borderWidth,
        );
      case SldsButtonVariant.ghost:
        return _SldsButtonVisualStyle(
          background: state == SldsComponentState.active
              ? colors.buttonGhostPressed
              : state == SldsComponentState.hover
                  ? colors.buttonGhostHover
                  : colors.surfacePage.withAlpha(
                      tokens.dimensions.transparentAlpha,
                    ),
          foreground: colors.buttonGhostLabel,
          border: colors.surfacePage.withAlpha(
            tokens.dimensions.transparentAlpha,
          ),
          borderWidth: borderWidth,
        );
      case SldsButtonVariant.destructive:
        return _SldsButtonVisualStyle(
          background: state == SldsComponentState.active
              ? colors.buttonDestructivePressed
              : state == SldsComponentState.hover
                  ? colors.buttonDestructiveHover
                  : colors.buttonDestructiveBackground,
          foreground: colors.buttonDestructiveLabel,
          border: colors.buttonDestructiveBackground,
          borderWidth: borderWidth,
        );
    }
  }
}
