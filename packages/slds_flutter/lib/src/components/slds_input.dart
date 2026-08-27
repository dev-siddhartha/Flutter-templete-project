import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slds_flutter/src/component_utils.dart';

import '../styles/slds_input_style.dart';
import '../theme/slds_theme.dart';
import 'slds_state.dart';

/// Figma-backed SLDS text input.
class SldsInput extends StatelessWidget {
  /// Creates an SLDS input.
  const SldsInput({
    super.key,
    this.textCapitalization = TextCapitalization.words,
    this.label,
    required this.controller,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.required = false,
    this.state = SldsComponentState.defaultState,
    this.leading,
    this.trailing,
    this.onChanged,
    this.keyboardType,
    this.semanticLabel,
    this.width,
    this.obscureText = false,
    this.focusNode,
    this.autofocus = false,
    this.readOnly = false,
    this.maxLength,
    this.filled = false,
    this.inputFormatters,
    this.textInputAction,
    this.onSubmitted,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUnfocus,
    this.style,
  });

  final String? label;

  final TextEditingController controller;

  final String? placeholder;

  final String? helperText;

  /// Overrides [helperText] when [state] is error.
  final String? errorText;

  final bool required;

  final SldsComponentState state;

  final Widget? leading;

  final Widget? trailing;

  final ValueChanged<String>? onChanged;

  final TextInputType? keyboardType;

  final String? semanticLabel;

  /// When null, fills the parent.
  final double? width;

  /// Password mode.
  final bool obscureText;

  final FocusNode? focusNode;

  final bool autofocus;

  /// Text visible but not editable.
  final bool readOnly;

  final int? maxLength;

  final bool filled;

  /// e.g. digits only.
  final List<TextInputFormatter>? inputFormatters;

  final TextInputAction? textInputAction;

  final ValueChanged<String>? onSubmitted;

  /// Requires the field to be inside a [Form] widget.
  final String? Function(String?)? validator;

  final AutovalidateMode autovalidateMode;

  /// Null fields inherit from the active [SldsTokenSet].
  final SldsInputStyle? style;

  /// for handling the capitalization here
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final colors = tokens.colors;
    final dimensions = tokens.dimensions;
    final s = style;
    final disabled = sldsStateIsDisabled(state);
    final error = state == SldsComponentState.error;
    final success = state == SldsComponentState.success;

    final labelColor = disabled
        ? colors.disabledForeground
        : (s?.labelColor ?? colors.inputLabel);
    final supportText = error ? errorText : helperText;
    final supportColor = disabled
        ? colors.disabledForeground
        : error
            ? colors.error
            : success
                ? colors.success
                : colors.inputHelper;

    return Semantics(
      textField: true,
      enabled: !disabled,
      label: semanticLabel ?? label,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label != null) ...[
              _SldsFieldLabel(
                label: label,
                required: required,
                color: labelColor,
                requiredColor: disabled
                    ? colors.disabledForeground
                    : colors.inputBorderError,
                labelStyle: s?.labelStyle,
              ),
              SizedBox(height: dimensions.space4),
            ],
            TextFormField(
              controller: controller,
              focusNode: focusNode,
              enabled: !disabled,
              autofocus: autofocus,
              readOnly: readOnly,
              obscureText: obscureText,
              keyboardType: keyboardType,
              textCapitalization: textCapitalization,
              textInputAction: textInputAction,
              maxLength: maxLength,
              inputFormatters: inputFormatters,
              onChanged: onChanged,
              onFieldSubmitted: onSubmitted,
              validator: validator,
              style: (s?.inputStyle ?? tokens.typography.body1).copyWith(
                color:
                    disabled ? colors.disabledForeground : colors.textPrimary,
              ),
              autovalidateMode: autovalidateMode,
              decoration: InputDecoration(
                counterText: '',
                constraints: BoxConstraints(
                  minHeight: dimensions.tapTargetMin,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: dimensions.space8,
                  horizontal: dimensions.space12,
                ),
                hintText: placeholder,
                hintStyle: (s?.hintStyle ?? tokens.typography.body1)
                    .copyWith(color: colors.inputPlaceholder),
                prefixIcon: leading,
                suffixIcon: trailing,
                suffixIconColor: colors.textSecondary,
                prefixIconColor: colors.textSecondary,
                prefixStyle: TextStyle(color: colors.textSecondary),
                border: globalBorder(color: colors.borderDefault),
                errorBorder: globalBorder(
                    color: colors.error, borderRadius: s?.borderRadius),
                focusedBorder: globalBorder(
                    color: colors.inputBorderFocused,
                    borderRadius: s?.borderRadius),
                enabledBorder: globalBorder(
                    color: colors.borderDefault, borderRadius: s?.borderRadius),
                disabledBorder: globalBorder(
                    color: colors.inputBorderDisabled,
                    width: dimensions.inputDisabledBorderWidth,
                    borderRadius: s?.borderRadius),
                focusedErrorBorder: globalBorder(
                    color: colors.error, borderRadius: s?.borderRadius),
                errorStyle: TextStyle(color: colors.error),
                labelStyle: TextStyle(color: colors.inputLabel),
                helperStyle: TextStyle(color: colors.inputHelper),
                fillColor: s?.backgroundColor ?? colors.surfaceCard,
                filled: filled,
              ),
            ),
            if (supportText != null) ...[
              SizedBox(height: dimensions.space6),
              Text(
                supportText,
                locale: Localizations.maybeLocaleOf(context),
                style: (error
                        ? (s?.errorStyle ?? tokens.typography.caption1)
                        : (s?.helperStyle ?? tokens.typography.caption1))
                    .copyWith(color: supportColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SldsFieldLabel extends StatelessWidget {
  const _SldsFieldLabel({
    this.label,
    required this.required,
    required this.color,
    required this.requiredColor,
    this.labelStyle,
  });

  final String? label;
  final bool required;
  final Color color;
  final Color requiredColor;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final base = labelStyle ?? tokens.typography.body1;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            label ?? "",
            locale: Localizations.maybeLocaleOf(context),
            style: base.copyWith(color: color),
          ),
        ),
        if (required)
          Text(
            '*',
            style: base.copyWith(color: requiredColor),
          ),
      ],
    );
  }
}
