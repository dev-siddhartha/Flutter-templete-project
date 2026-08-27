import 'package:flutter/widgets.dart';

import '../styles/slds_badge_style.dart';
import '../theme/slds_theme.dart';
import 'slds_focus.dart';
import 'slds_state.dart';

/// SLDS badge/status types from Figma.
enum SldsBadgeType {
  success,

  pending,

  error,

  info,

  neutral,

  draft,

  submitted,

  inReview,

  approved,

  rejected,

  escalated,

  onHold,

  archived,
}

/// Figma-backed SLDS badge.
class SldsBadge extends StatelessWidget {
  /// Creates an SLDS badge.
  const SldsBadge({
    super.key,
    required this.label,
    this.type = SldsBadgeType.neutral,
    this.state,
    this.icon,
    this.style,
  });

  final String label;

  final SldsBadgeType type;

  final SldsComponentState? state;

  final IconData? icon;

  /// Visual style overrides. Null fields inherit from the active [SldsTokenSet].
  final SldsBadgeStyle? style;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final resolvedType = _typeForState(type, state);
    final colors = _colors(context, resolvedType);
    final disabled = state == SldsComponentState.disabled ||
        state == SldsComponentState.loading;
    final border = _borderColor(context, state);
    final effectiveBg = style?.backgroundColor ??
        (disabled ? tokens.colors.disabledBackground : colors.background);
    final effectiveFg = style?.foregroundColor ??
        (disabled ? tokens.colors.disabledForeground : colors.foreground);
    final effectiveBr = style?.borderRadius ?? tokens.dimensions.radius3xl;
    final effectivePadding = style?.padding ??
        EdgeInsets.symmetric(
          horizontal: tokens.dimensions.space12,
          vertical: tokens.dimensions.space4,
        );
    final effectiveTextStyle = style?.textStyle ??
        tokens.typography.body1.copyWith(color: effectiveFg);
    return Semantics(
      label: label,
      child: Container(
        padding: effectivePadding,
        decoration: BoxDecoration(
          color: effectiveBg,
          borderRadius: BorderRadius.circular(effectiveBr),
          border: border == null ? null : Border.all(color: border),
          boxShadow:
              state == SldsComponentState.focus ? sldsFocusRing(tokens) : null,
        ),
        child: Row(
          spacing: tokens.dimensions.space8,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) Icon(icon, color: effectiveFg),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                locale: Localizations.maybeLocaleOf(context),
                style: effectiveTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _BadgeColors _colors(BuildContext context, SldsBadgeType type) {
    final c = context.slds.colors;
    switch (type) {
      case SldsBadgeType.success:
        return _BadgeColors(c.badgeSuccessText, c.badgeSuccessBackground);
      case SldsBadgeType.pending:
        return _BadgeColors(c.badgePendingText, c.badgePendingBackground);
      case SldsBadgeType.error:
        return _BadgeColors(c.badgeErrorText, c.badgeErrorBackground);
      case SldsBadgeType.info:
        return _BadgeColors(c.badgeInfoText, c.badgeInfoBackground);
      case SldsBadgeType.neutral:
      case SldsBadgeType.draft:
      case SldsBadgeType.archived:
        return _BadgeColors(c.badgeNeutralText, c.badgeNeutralBackground);
      case SldsBadgeType.submitted:
        return _BadgeColors(c.badgeSubmittedText, c.badgeSubmittedBackground);
      case SldsBadgeType.inReview:
        return _BadgeColors(c.badgeInReviewText, c.badgeInReviewBackground);
      case SldsBadgeType.approved:
        return _BadgeColors(c.badgeApprovedText, c.badgeApprovedBackground);
      case SldsBadgeType.rejected:
        return _BadgeColors(c.badgeErrorText, c.badgeErrorBackground);
      case SldsBadgeType.escalated:
        return _BadgeColors(c.badgeEscalatedText, c.badgeEscalatedBackground);
      case SldsBadgeType.onHold:
        return _BadgeColors(c.badgeOnHoldText, c.badgeOnHoldBackground);
    }
  }

  SldsBadgeType _typeForState(
    SldsBadgeType fallback,
    SldsComponentState? state,
  ) {
    switch (state) {
      case SldsComponentState.error:
        return SldsBadgeType.error;
      case SldsComponentState.success:
        return SldsBadgeType.success;
      case SldsComponentState.empty:
        return SldsBadgeType.neutral;
      case SldsComponentState.loading:
        return SldsBadgeType.pending;
      case _:
        return fallback;
    }
  }

  Color? _borderColor(BuildContext context, SldsComponentState? state) {
    final colors = context.slds.colors;
    switch (state) {
      case SldsComponentState.error:
        return colors.error;
      case SldsComponentState.success:
        return colors.success;
      case SldsComponentState.focus:
        return colors.focusRing;
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

class _BadgeColors {
  const _BadgeColors(this.foreground, this.background);

  final Color foreground;
  final Color background;
}
