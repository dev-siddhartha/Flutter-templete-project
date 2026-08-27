import 'package:flutter/material.dart';

import '../styles/slds_snackbar_style.dart';
import '../theme/slds_theme.dart';
import 'slds_button.dart';
import 'slds_focus.dart';
import 'slds_state.dart';

/// Figma-backed SLDS snackbar.
class SldsSnackbar extends StatelessWidget {
  /// Creates an SLDS snackbar.
  const SldsSnackbar({
    super.key,
    required this.title,
    this.description,
    this.actionLabel,
    this.onAction,
    this.state,
    this.width,
    this.onDismiss,
    this.dismissSemanticLabel,
    this.style,
  });

  /// Snackbar title.
  final String title;

  /// Optional description text.
  final String? description;

  /// Optional action button label.
  final String? actionLabel;

  /// Optional action callback.
  final VoidCallback? onAction;

  /// Optional forced visual state.
  final SldsComponentState? state;

  /// Optional fixed width. When null uses the token default (361 px).
  final double? width;

  /// When provided, a dismiss (×) button is shown and this callback is fired.
  final VoidCallback? onDismiss;

  /// Accessible label for the dismiss button.
  /// Defaults to 'Dismiss' when null — pass your app's localized string.
  final String? dismissSemanticLabel;

  /// Visual style overrides. Null fields inherit from the active [SldsTokenSet].
  final SldsSnackbarStyle? style;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final s = style;
    final disabled = state == SldsComponentState.disabled ||
        state == SldsComponentState.loading;
    final border = s?.borderColor ?? sldsSurfaceBorderColor(tokens, state);
    final titleColor = disabled
        ? tokens.colors.disabledForeground
        : state == SldsComponentState.error
            ? tokens.colors.error
            : state == SldsComponentState.success
                ? tokens.colors.success
                : tokens.colors.textPrimary;
    final shadows = <BoxShadow>[
      if (state == SldsComponentState.focus) ...sldsFocusRing(tokens),
      BoxShadow(
        color: tokens.colors.textPrimary.withAlpha(
          tokens.dimensions.elevationAlpha,
        ),
        blurRadius: tokens.dimensions.snackbarShadowBlur,
        offset: Offset(
          tokens.dimensions.space0,
          tokens.dimensions.elevationOffsetY,
        ),
      ),
    ];
    return Semantics(
      liveRegion: true,
      explicitChildNodes: true,
      label: description == null ? title : '$title. $description',
      child: Container(
        width: width ?? tokens.dimensions.snackbarWidth,
        padding: s?.padding ??
            EdgeInsets.symmetric(
              horizontal: tokens.dimensions.space16,
              vertical: tokens.dimensions.space12,
            ),
        decoration: BoxDecoration(
          color: s?.backgroundColor ??
              (disabled
                  ? tokens.colors.disabledBackground
                  : tokens.colors.surfaceCard),
          borderRadius: BorderRadius.circular(
            s?.borderRadius ?? tokens.dimensions.radius2xl,
          ),
          border: border == null ? null : Border.all(color: border),
          boxShadow: shadows,
        ),
        child: Row(
          children: [
            Expanded(
              child: ExcludeSemantics(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      locale: Localizations.maybeLocaleOf(context),
                      style: (s?.titleStyle ?? tokens.typography.body2)
                          .copyWith(color: titleColor),
                    ),
                    if (description != null) ...[
                      SizedBox(height: tokens.dimensions.space4),
                      Text(
                        description!,
                        locale: Localizations.maybeLocaleOf(context),
                        style: (s?.descriptionStyle ??
                                tokens.typography.snackbarCaption)
                            .copyWith(color: tokens.colors.textSecondary),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (actionLabel != null) ...[
              SizedBox(width: tokens.dimensions.space16),
              SldsButton(
                size: SldsButtonSize.small,
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
            if (onDismiss != null) ...[
              SizedBox(width: tokens.dimensions.space8),
              Semantics(
                button: true,
                label: dismissSemanticLabel ?? 'Dismiss',
                child: GestureDetector(
                  excludeFromSemantics: true,
                  onTap: onDismiss,
                  child: SizedBox.square(
                    dimension: tokens.dimensions.tapTargetMin,
                    child: Center(
                      child: Icon(
                        Icons.close,
                        size: tokens.dimensions.iconSizeMedium,
                        color:
                            s?.dismissIconColor ?? tokens.colors.textSecondary,
                      ),
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
