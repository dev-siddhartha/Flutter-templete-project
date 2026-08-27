import 'package:flutter/material.dart';

import '../styles/slds_checkbox_style.dart';
import '../theme/slds_theme.dart';
import 'slds_focus.dart';
import 'slds_state.dart';

/// SLDS checkbox size.
enum SldsCheckboxSize {
  /// 16px.
  defaultSize,

  /// 24px.
  large,
}

/// Figma-backed SLDS checkbox.
class SldsCheckbox extends StatefulWidget {
  /// Creates an SLDS checkbox.
  SldsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.indeterminate = false,
    this.size = SldsCheckboxSize.large,
    this.state,
    this.semanticLabel,
    this.activeColor,
    this.style,
  }) : assert(activeColor == null || style?.activeColor == null,
            'activeColor and style.activeColor are mutually exclusive, only one can be provided.');

  final bool value;

  final ValueChanged<bool>? onChanged;

  final String? label;

  final bool indeterminate;

  final SldsCheckboxSize size;

  final SldsComponentState? state;

  final String? semanticLabel;

  /// Selected fill color. When null, uses the primary button background
  /// from the active token set.
  final Color? activeColor;

  final SldsCheckboxStyle? style;

  @override
  State<SldsCheckbox> createState() => _SldsCheckboxState();
}

class _SldsCheckboxState extends State<SldsCheckbox> {
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
    final size = widget.size == SldsCheckboxSize.large
        ? dimensions.checkboxLarge
        : dimensions.checkboxDefault;
    final radius = s?.borderRadius ??
        (widget.size == SldsCheckboxSize.large
            ? dimensions.radiusMd + dimensions.space4 / 2
            : dimensions.radiusMd);
    final selected = widget.value || widget.indeterminate;
    final fill = !enabled
        ? colors.disabledBackground
        : selected
            ? (widget.activeColor ??
                s?.activeColor ??
                colors.buttonPrimaryBackground)
            : state == SldsComponentState.hover
                ? colors.surfaceHover
                : (s?.inactiveColor ?? colors.surfacePrimary);
    final Color? border;
    if (!enabled) {
      border = colors.disabledForeground;
    } else if (state == SldsComponentState.error) {
      border = colors.error;
    } else if (state == SldsComponentState.success) {
      border = colors.success;
    } else if (selected) {
      border = state == SldsComponentState.focus
          ? (widget.activeColor ??
              s?.activeColor ??
              colors.buttonPrimaryBackground)
          : null;
    } else {
      border = s?.inactiveColor ?? colors.borderDefault;
    }
    final borderWidth = widget.size == SldsCheckboxSize.large
        ? dimensions.emphasizedBorderWidth
        : dimensions.controlBorderWidth;
    final markColor = s?.checkmarkColor ??
        (enabled ? colors.buttonPrimaryLabel : colors.disabledForeground);

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
              widget.onChanged?.call(!widget.value);
            }
            return null;
          },
        ),
      },
      child: GestureDetector(
        excludeFromSemantics: true,
        onTap: enabled ? () => widget.onChanged?.call(!widget.value) : null,
        child: SizedBox.square(
          dimension: dimensions.tapTargetMin,
          child: Center(
            child: AnimatedContainer(
              duration: tokens.motion.fast,
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: fill,
                border: border == null
                    ? null
                    : Border.all(color: border, width: borderWidth),
                borderRadius: BorderRadius.circular(radius),
                boxShadow: state == SldsComponentState.focus
                    ? sldsFocusRing(tokens)
                    : null,
              ),
              child: selected
                  ? Icon(
                      widget.indeterminate ? Icons.remove : Icons.check,
                      size: size - dimensions.space8,
                      color: markColor,
                    )
                  : null,
            ),
          ),
        ),
      ),
    );

    return Semantics(
      checked: widget.indeterminate ? null : widget.value,
      mixed: widget.indeterminate,
      enabled: enabled,
      label: widget.semanticLabel ?? widget.label,
      onTap: enabled ? () => widget.onChanged?.call(!widget.value) : null,
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
