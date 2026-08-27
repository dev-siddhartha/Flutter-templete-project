import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slds_flutter/slds_flutter.dart';

/// Figma-backed SLDS text area.
class SldsTextArea extends StatefulWidget {
  /// Creates an SLDS text area.
  const SldsTextArea({
    super.key,
    required this.label,
    required this.controller,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.required = false,
    this.maxLength,
    this.state = SldsComponentState.defaultState,
    this.onChanged,
    this.width,
    this.height,
    this.focusNode,
    this.autofocus = false,
    this.readOnly = false,
    this.inputFormatters,
    this.textInputAction,
    this.onSubmitted,
    this.validator,
    this.style,
  });

  final String label;

  final TextEditingController controller;

  final String? placeholder;

  final String? helperText;

  /// Overrides [helperText] when [state] is error.
  final String? errorText;

  final bool required;

  /// Shows a character counter when set.
  final int? maxLength;

  final SldsComponentState state;

  final ValueChanged<String>? onChanged;

  /// When null, fills the parent.
  final double? width;

  /// When null, uses the token default (128 px).
  final double? height;

  final FocusNode? focusNode;

  final bool autofocus;

  final bool readOnly;

  final List<TextInputFormatter>? inputFormatters;

  final TextInputAction? textInputAction;

  final ValueChanged<String>? onSubmitted;

  /// Requires the field to be inside a [Form] widget.
  final String? Function(String?)? validator;

  /// Null fields inherit from the active [SldsTokenSet].
  final SldsTextAreaStyle? style;

  @override
  State<SldsTextArea> createState() => _SldsTextAreaState();
}

class _SldsTextAreaState extends State<SldsTextArea> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final colors = tokens.colors;
    final dimensions = tokens.dimensions;
    final s = widget.style;
    final disabled = sldsStateIsDisabled(widget.state);
    final error = widget.state == SldsComponentState.error;
    final success = widget.state == SldsComponentState.success;

    final labelColor = disabled
        ? colors.disabledForeground
        : (s?.labelColor ?? colors.inputLabel);
    final supportColor = disabled
        ? colors.disabledForeground
        : error
            ? colors.error
            : success
                ? colors.success
                : colors.inputHelper;
    final supportText = error ? widget.errorText : widget.helperText;

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    widget.label,
                    locale: Localizations.maybeLocaleOf(context),
                    style: (s?.labelStyle ?? tokens.typography.body1).copyWith(
                      color: labelColor,
                    ),
                  ),
                ),
                if (widget.required)
                  Text(
                    '*',
                    style: (s?.labelStyle ?? tokens.typography.body1).copyWith(
                      color: disabled
                          ? colors.disabledForeground
                          : colors.inputBorderError,
                    ),
                  ),
              ],
            ),
            SizedBox(height: dimensions.space4),
            TextFormField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              enabled: !disabled,
              autofocus: widget.autofocus,
              readOnly: widget.readOnly,
              keyboardType: TextInputType.multiline,
              textInputAction: widget.textInputAction,
              maxLength: widget.maxLength,
              inputFormatters: widget.inputFormatters,
              onChanged: widget.onChanged,
              onFieldSubmitted: widget.onSubmitted,
              validator: widget.validator,
              style: (s?.inputStyle ?? tokens.typography.body1).copyWith(
                color:
                    disabled ? colors.disabledForeground : colors.textPrimary,
              ),
              maxLines: null,
              minLines: 6,
              decoration: InputDecoration(
                counterText: '',
                isCollapsed: true,
                hintText: widget.placeholder,
                contentPadding: EdgeInsets.only(
                  left: tokens.dimensions.space8,
                  right: tokens.dimensions.space8,
                  bottom: tokens.dimensions.space20,
                  top: tokens.dimensions.space8,
                ),
                hintStyle: (s?.hintStyle ?? tokens.typography.body1)
                    .copyWith(color: colors.inputPlaceholder),
                suffixIconColor: colors.textSecondary,
                prefixIconColor: colors.textSecondary,
                prefixStyle: TextStyle(color: colors.textSecondary),
                border: globalBorder(color: colors.borderDefault),
                errorBorder: globalBorder(color: colors.error),
                focusedBorder: globalBorder(color: colors.inputBorderFocused),
                enabledBorder: globalBorder(color: colors.borderDefault),
                disabledBorder: globalBorder(color: colors.inputBorderDisabled),
                focusedErrorBorder: globalBorder(color: colors.error),
                errorStyle: TextStyle(color: colors.error),
                labelStyle: TextStyle(color: colors.inputLabel),
                helperStyle: TextStyle(color: colors.inputHelper),
                fillColor: colors.surfaceCard,
                filled: false,
              ),
            ),
            if (widget.maxLength != null)
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
        Positioned(
          bottom: 8.h,
          right: 10.w,
          child: ValueListenableBuilder<TextEditingValue>(
            valueListenable: widget.controller,
            builder: (context, value, _) {
              final characterCount = value.text.characters.length;
              return Text(
                '$characterCount/${widget.maxLength}',
                style: tokens.typography.caption1.copyWith(
                  color:
                      disabled ? colors.disabledForeground : colors.inputHelper,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
