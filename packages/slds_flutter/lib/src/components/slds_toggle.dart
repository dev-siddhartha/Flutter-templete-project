import 'package:flutter/widgets.dart';

import '../styles/slds_toggle_style.dart';
import '../theme/slds_theme.dart';
import 'slds_focus.dart';
import 'slds_state.dart';

/// Figma-backed SLDS toggle switch.
class SldsToggle extends StatefulWidget {
  /// Creates an SLDS toggle.
  const SldsToggle({
    super.key,
    required this.value,
    required this.onChanged,
    this.state,
    this.semanticLabel,
    this.style,
  });

  /// Toggle value.
  final bool value;

  /// Change callback.
  final ValueChanged<bool>? onChanged;

  /// Optional forced visual state.
  final SldsComponentState? state;

  /// Screen reader label.
  final String? semanticLabel;

  /// Visual style overrides. Null fields inherit from the active [SldsTokenSet].
  final SldsToggleStyle? style;

  @override
  State<SldsToggle> createState() => _SldsToggleState();
}

class _SldsToggleState extends State<SldsToggle> {
  var _focused = false;
  var _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final dimensions = tokens.dimensions;
    final colors = tokens.colors;
    final state = widget.state ??
        (_focused
            ? SldsComponentState.focus
            : _hovered
                ? SldsComponentState.hover
                : SldsComponentState.defaultState);
    final enabled = widget.onChanged != null && !sldsStateIsDisabled(state);
    final Color trackColor;
    if (!enabled) {
      trackColor =
          widget.style?.inactiveTrackColor ?? colors.disabledBackground;
    } else if (state == SldsComponentState.error) {
      trackColor = colors.error;
    } else if (state == SldsComponentState.success) {
      trackColor = colors.success;
    } else if (widget.value) {
      trackColor =
          widget.style?.activeTrackColor ?? colors.buttonPrimaryBackground;
    } else {
      // borderDefault (not disabledBackground) so the off track stays visible
      // against the thumb: surfacePrimary and disabledBackground collapse to
      // the same neutral shade in the dark scheme, making the two
      // indistinguishable there.
      trackColor = widget.style?.inactiveTrackColor ?? colors.borderDefault;
    }
    final thumbColor = enabled
        ? (widget.value
            ? widget.style?.thumbColor ?? colors.surfacePrimary
            : widget.style?.inactiveThumbColor ?? colors.surfacePrimary)
        : (widget.style?.inactiveThumbColor ?? colors.disabledForeground);

    return Semantics(
      toggled: widget.value,
      enabled: enabled,
      label: widget.semanticLabel,
      onTap: enabled ? () => widget.onChanged?.call(!widget.value) : null,
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
                widget.onChanged?.call(!widget.value);
              }
              return null;
            },
          ),
        },
        child: GestureDetector(
          excludeFromSemantics: true,
          onTap: enabled ? () => widget.onChanged?.call(!widget.value) : null,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: dimensions.tapTargetMin,
              minHeight: dimensions.tapTargetMin,
            ),
            child: Center(
              // 1.0 here is the Center shrink-wrap idiom (size to child),
              // not a themable dimension — do not source it from tokens.
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: AnimatedContainer(
                duration: tokens.motion.fast,
                width: dimensions.toggleWidth,
                height: dimensions.toggleHeight,
                padding: EdgeInsets.symmetric(horizontal: dimensions.space4),
                decoration: BoxDecoration(
                  color: trackColor,
                  borderRadius: BorderRadius.circular(dimensions.radiusFull),
                  boxShadow: state == SldsComponentState.focus
                      ? sldsFocusRing(tokens)
                      : null,
                ),
                alignment:
                    widget.value ? Alignment.centerRight : Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: tokens.motion.fast,
                  width: dimensions.toggleThumb,
                  height: dimensions.toggleThumb,
                  decoration: BoxDecoration(
                    color: thumbColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: colors.textPrimary.withAlpha(
                          dimensions.elevationAlpha,
                        ),
                        blurRadius: dimensions.elevationBlur,
                        offset: Offset(
                          dimensions.space0,
                          dimensions.elevationOffsetY,
                        ),
                        spreadRadius: dimensions.elevationSpread,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
