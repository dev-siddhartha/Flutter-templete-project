import 'package:flutter/widgets.dart';

import '../styles/slds_dialog_style.dart';
import '../theme/slds_theme.dart';
import 'slds_button.dart';
import 'slds_focus.dart';
import 'slds_state.dart';

/// Figma-backed SLDS dialog body.
class SldsDialog extends StatelessWidget {
  /// Creates an SLDS dialog.
  const SldsDialog({
    super.key,
    required this.title,
    required this.message,
    this.primaryAction,
    this.secondaryAction,
    this.state,
    this.width,
    this.fallbackActionLabel,
    this.onFallbackAction,
    this.style,
    this.icon,
  });

  final String title;

  final String message;

  /// When null and [fallbackActionLabel] is set, a plain button with that
  /// label is rendered instead.
  final Widget? primaryAction;

  final Widget? secondaryAction;

  final SldsComponentState? state;

  /// When null, uses the token default (300 px).
  final double? width;

  /// Label for the auto-generated button shown when [primaryAction] is null.
  /// Pass a localized string. No button renders if both are null.
  final String? fallbackActionLabel;

  final VoidCallback? onFallbackAction;

  final SldsDialogStyle? style;

  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final disabled = state == SldsComponentState.disabled ||
        state == SldsComponentState.loading;
    final border = style?.borderColor ?? _borderColor(context, state);
    final titleColor = disabled
        ? tokens.colors.disabledForeground
        : state == SldsComponentState.error
            ? tokens.colors.error
            : state == SldsComponentState.success
                ? tokens.colors.success
                : tokens.colors.textPrimary;
    final effectiveBg = style?.backgroundColor ??
        (disabled
            ? tokens.colors.disabledBackground
            : tokens.colors.surfaceCard);
    final effectiveBr = style?.borderRadius ?? tokens.dimensions.radius2xl;
    final effectivePadding = style?.padding ??
        EdgeInsets.symmetric(
          horizontal: tokens.dimensions.space16,
          vertical: tokens.dimensions.space12,
        );
    final effectiveTitleStyle = style?.titleStyle ??
        tokens.typography.desktopTitle1.copyWith(color: titleColor);
    final effectiveMessageStyle = style?.messageStyle ??
        tokens.typography.body2.copyWith(color: tokens.colors.textSecondary);
    final shadows = <BoxShadow>[
      if (state == SldsComponentState.focus) ...sldsFocusRing(tokens),
      BoxShadow(
        color: tokens.colors.textPrimary.withAlpha(
          tokens.dimensions.elevationAlpha,
        ),
        blurRadius: tokens.dimensions.elevationBlur,
        offset: Offset(
          tokens.dimensions.space0,
          tokens.dimensions.elevationOffsetY,
        ),
        spreadRadius: tokens.dimensions.elevationSpread,
      ),
    ];
    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: title,
      child: Container(
        width: width ?? tokens.dimensions.dialogWidth,
        padding: effectivePadding,
        decoration: BoxDecoration(
          color: effectiveBg,
          borderRadius: BorderRadius.circular(effectiveBr),
          border: border == null ? null : Border.all(color: border),
          boxShadow: shadows,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) icon!,
            Text(
              title,
              locale: Localizations.maybeLocaleOf(context),
              style: effectiveTitleStyle,
            ),
            SizedBox(height: tokens.dimensions.space4),
            Text(
              message,
              locale: Localizations.maybeLocaleOf(context),
              style: effectiveMessageStyle,
            ),
            SizedBox(height: tokens.dimensions.space20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (secondaryAction != null) secondaryAction!,
                if (secondaryAction != null && primaryAction != null)
                  SizedBox(width: tokens.dimensions.space8),
                if (primaryAction != null)
                  primaryAction!
                else if (fallbackActionLabel != null)
                  SldsButton(
                    size: SldsButtonSize.medium,
                    onPressed: onFallbackAction,
                    child: Text(fallbackActionLabel!),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color? _borderColor(BuildContext context, SldsComponentState? state) {
    final colors = context.slds.colors;
    switch (state) {
      case SldsComponentState.error:
        return colors.error;
      case SldsComponentState.success:
        return colors.success;
      case SldsComponentState.focus:
      case SldsComponentState.active:
        return colors.inputBorderFocused;
      case SldsComponentState.hover:
      case SldsComponentState.empty:
      case SldsComponentState.disabled:
      case SldsComponentState.loading:
        return colors.borderDecorative;
      case _:
        return null;
    }
  }
}
