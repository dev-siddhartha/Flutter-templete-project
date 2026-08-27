import 'package:flutter/material.dart';

import '../styles/slds_radio_style.dart';
import '../theme/slds_theme.dart';
import 'slds_focus.dart';
import 'slds_state.dart';

/// SLDS radio size.
enum SldsRadioSize {
  /// 16px.
  defaultSize,

  /// 20px.
  large,
}

/// Figma-backed SLDS radio.
class SldsRadio<T> extends StatefulWidget {
  /// Creates an SLDS radio.
  const SldsRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.size = SldsRadioSize.defaultSize,
    this.state,
    this.semanticLabel,
    this.style,
  });

  /// This radio value.
  final T value;

  /// Current group value.
  final T? groupValue;

  /// Change callback.
  final ValueChanged<T?>? onChanged;

  /// Optional label.
  final String? label;

  /// Visual size.
  final SldsRadioSize size;

  /// Optional forced visual state.
  final SldsComponentState? state;

  /// Screen reader label.
  final String? semanticLabel;

  /// Visual style overrides. Null fields inherit from the active [SldsTokenSet].
  final SldsRadioStyle? style;

  @override
  State<SldsRadio<T>> createState() => _SldsRadioState<T>();
}

class _SldsRadioState<T> extends State<SldsRadio<T>> {
  var _focused = false;
  var _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final dimensions = tokens.dimensions;
    final colors = tokens.colors;
    final s = widget.style;
    final state = widget.state ??
        (_focused
            ? SldsComponentState.focus
            : _hovered
                ? SldsComponentState.hover
                : SldsComponentState.defaultState);
    final enabled = widget.onChanged != null && !sldsStateIsDisabled(state);
    final selected = widget.value == widget.groupValue;
    final size = widget.size == SldsRadioSize.large
        ? dimensions.radioLarge
        : dimensions.radioDefault;
    final dotSize = size - dimensions.space8;
    final fill = !enabled
        ? colors.disabledBackground
        : selected || state == SldsComponentState.focus
            ? colors.surfacePage
            : state == SldsComponentState.hover
                ? colors.surfaceHover
                : colors.surfacePrimary;
    final Color border;
    if (!enabled) {
      border = colors.disabledForeground;
    } else if (state == SldsComponentState.error) {
      border = colors.error;
    } else if (state == SldsComponentState.success) {
      border = colors.success;
    } else if (selected) {
      border = s?.activeColor ?? colors.inputBorderFocused;
    } else {
      border = s?.inactiveColor ?? colors.inputBorderDefault;
    }

    final control = FocusableActionDetector(
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
              widget.onChanged?.call(widget.value);
            }
            return null;
          },
        ),
      },
      child: GestureDetector(
        excludeFromSemantics: true,
        onTap: enabled ? () => widget.onChanged?.call(widget.value) : null,
        child: SizedBox.square(
          dimension: dimensions.tapTargetMin,
          child: Center(
            child: AnimatedContainer(
              duration: tokens.motion.fast,
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: fill,
                shape: BoxShape.circle,
                border: Border.all(
                  color: border,
                  width: dimensions.controlBorderWidth,
                ),
                boxShadow: state == SldsComponentState.focus
                    ? sldsFocusRing(tokens)
                    : null,
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: dotSize,
                        height: dotSize,
                        decoration: BoxDecoration(
                          color: enabled
                              ? (s?.dotColor ?? colors.inputBorderFocused)
                              : colors.disabledForeground,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );

    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: selected,
      enabled: enabled,
      label: widget.semanticLabel ?? widget.label,
      onTap: enabled ? () => widget.onChanged?.call(widget.value) : null,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: dimensions.tapTargetMin),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            control,
            if (widget.label != null) ...[
              Flexible(
                child: ExcludeSemantics(
                  child: Text(
                    widget.label!,
                    locale: Localizations.maybeLocaleOf(context),
                    style: (s?.labelStyle ?? tokens.typography.body1).copyWith(
                      color: enabled
                          ? colors.textPrimary
                          : colors.disabledForeground,
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
