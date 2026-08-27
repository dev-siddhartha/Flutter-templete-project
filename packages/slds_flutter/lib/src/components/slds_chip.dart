import 'package:flutter/material.dart';

import '../styles/slds_chip_style.dart';
import '../theme/slds_theme.dart';
import 'slds_avatar.dart';
import 'slds_focus.dart';
import 'slds_state.dart';

/// Figma-backed SLDS chip.
class SldsChip extends StatelessWidget {
  /// Creates an SLDS chip.
  const SldsChip({
    super.key,
    required this.label,
    this.leading,
    this.avatar,
    this.onDeleted,
    this.state,
    this.semanticLabel,
    this.style,
  });

  /// Chip label.
  final String label;

  /// Optional leading icon or custom widget.
  final Widget? leading;

  /// Optional avatar.
  final SldsAvatar? avatar;

  /// Remove callback.
  final VoidCallback? onDeleted;

  /// Optional forced visual state.
  final SldsComponentState? state;

  /// Screen reader label.
  final String? semanticLabel;

  /// Visual style overrides. Null fields inherit from the active [SldsTokenSet].
  final SldsChipStyle? style;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final chipColors = _ChipStyle.resolve(context, state);
    final hasVisualLead = avatar != null || leading != null;
    final disabled = state == SldsComponentState.disabled ||
        state == SldsComponentState.loading;
    final canDelete = onDeleted != null && !disabled;
    final effectiveBg = style?.backgroundColor ?? chipColors.background;
    final effectiveFg = style?.foregroundColor ?? chipColors.foreground;
    final effectiveBorder = style?.borderColor ?? chipColors.border;
    final effectiveBr = style?.borderRadius ?? tokens.dimensions.radiusFull;
    final effectiveTextStyle = style?.textStyle ??
        tokens.typography.body1.copyWith(color: effectiveFg);

    final children = <Widget>[
      if (avatar != null) avatar!,
      if (leading != null)
        IconTheme.merge(
          data: IconThemeData(
            color: effectiveFg,
            size: tokens.dimensions.iconSizeMedium,
          ),
          child: leading!,
        ),
      Flexible(
        child: Text(
          label,
          locale: Localizations.maybeLocaleOf(context),
          style: effectiveTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      if (state == SldsComponentState.loading)
        SizedBox.square(
          dimension: tokens.dimensions.avatarIconMedium,
          child: CircularProgressIndicator(
            strokeWidth: tokens.dimensions.progressStrokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(effectiveFg),
          ),
        )
      else if (onDeleted != null)
        Semantics(
          button: true,
          enabled: canDelete,
          label: semanticLabel,
          child: FocusableActionDetector(
            enabled: canDelete,
            includeFocusSemantics: false,
            mouseCursor:
                canDelete ? SystemMouseCursors.click : SystemMouseCursors.basic,
            actions: {
              ActivateIntent: CallbackAction<ActivateIntent>(
                onInvoke: (_) {
                  if (canDelete) onDeleted?.call();
                  return null;
                },
              ),
            },
            child: GestureDetector(
              excludeFromSemantics: true,
              onTap: canDelete ? onDeleted : null,
              child: Icon(
                Icons.close,
                size: tokens.dimensions.avatarIconMedium,
                color: effectiveFg,
              ),
            ),
          ),
        ),
    ];

    return Semantics(
      label: semanticLabel ?? label,
      enabled: !disabled,
      child: AnimatedContainer(
        duration: tokens.motion.fast,
        padding: style?.padding ??
            EdgeInsets.only(
              left: hasVisualLead
                  ? tokens.dimensions.space4
                  : tokens.dimensions.space8,
              right: tokens.dimensions.space8,
              top: tokens.dimensions.space4,
              bottom: tokens.dimensions.space4,
            ),
        decoration: BoxDecoration(
          color: effectiveBg,
          borderRadius: BorderRadius.circular(effectiveBr),
          border: Border.all(color: effectiveBorder),
          boxShadow:
              state == SldsComponentState.focus ? sldsFocusRing(tokens) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < children.length; i++) ...[
              if (i > 0)
                SizedBox(
                  width: hasVisualLead && i == 1
                      ? tokens.dimensions.space8
                      : tokens.dimensions.space4,
                ),
              children[i],
            ],
          ],
        ),
      ),
    );
  }
}

class _ChipStyle {
  const _ChipStyle({
    required this.background,
    required this.foreground,
    required this.border,
  });

  final Color background;
  final Color foreground;
  final Color border;

  static _ChipStyle resolve(BuildContext context, SldsComponentState? state) {
    final tokens = context.slds;
    final c = tokens.colors;
    final transparent =
        c.surfaceCard.withAlpha(tokens.dimensions.transparentAlpha);
    switch (state) {
      case SldsComponentState.disabled:
        return _ChipStyle(
          background: c.disabledBackground,
          foreground: c.disabledForeground,
          border: c.disabledBackground,
        );
      case SldsComponentState.error:
        return _ChipStyle(
          background: c.badgeErrorBackground,
          foreground: c.error,
          border: c.error,
        );
      case SldsComponentState.success:
        return _ChipStyle(
          background: c.badgeSuccessBackground,
          foreground: c.success,
          border: c.success,
        );
      case SldsComponentState.hover:
      case SldsComponentState.empty:
        return _ChipStyle(
          background: c.surfaceHover,
          foreground: c.textPrimary,
          border: c.borderDecorative,
        );
      case SldsComponentState.focus:
        return _ChipStyle(
          background: c.badgeNeutralBackground,
          foreground: c.textPrimary,
          border: c.focusRing,
        );
      case SldsComponentState.active:
        return _ChipStyle(
          background: c.badgeInReviewBackground,
          foreground: c.badgeInReviewText,
          border: c.badgeInReviewText,
        );
      case SldsComponentState.loading:
        return _ChipStyle(
          background: c.badgePendingBackground,
          foreground: c.badgePendingText,
          border: c.badgePendingText,
        );
      case SldsComponentState.defaultState:
      case null:
        return _ChipStyle(
          background: c.badgeNeutralBackground,
          foreground: c.textPrimary,
          border: transparent,
        );
    }
  }
}
