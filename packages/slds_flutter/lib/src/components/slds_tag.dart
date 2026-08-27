import 'package:flutter/widgets.dart';

import '../styles/slds_tag_style.dart';
import '../theme/slds_theme.dart';
import 'slds_badge.dart';
import 'slds_focus.dart';
import 'slds_state.dart';

/// SLDS tag uses the badge palette with a compact, non-removable label shape.
class SldsTag extends StatelessWidget {
  /// Creates an SLDS tag.
  const SldsTag({
    super.key,
    required this.label,
    this.type = SldsBadgeType.neutral,
    this.state,
    this.style,
  });

  /// Tag label.
  final String label;

  /// Semantic color type.
  final SldsBadgeType type;

  /// Optional forced visual state.
  final SldsComponentState? state;

  /// Visual style overrides. Null fields inherit from the active [SldsTokenSet].
  final SldsTagStyle? style;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final colors = _TagColors.resolve(context, type, state);
    final effectiveBg = style?.backgroundColor ?? colors.background;
    final effectiveFg = style?.foregroundColor ?? colors.foreground;
    final effectiveBr = style?.borderRadius ?? tokens.dimensions.radiusXl;
    final effectivePadding = style?.padding ??
        EdgeInsets.symmetric(
          horizontal: tokens.dimensions.space8,
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
          border: Border.all(color: colors.border),
          boxShadow:
              state == SldsComponentState.focus ? sldsFocusRing(tokens) : null,
        ),
        child: Text(
          label,
          locale: Localizations.maybeLocaleOf(context),
          style: effectiveTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _TagColors {
  const _TagColors(this.foreground, this.background, this.border);

  final Color foreground;
  final Color background;
  final Color border;

  static _TagColors resolve(
    BuildContext context,
    SldsBadgeType type,
    SldsComponentState? state,
  ) {
    final tokens = context.slds;
    final c = tokens.colors;
    final transparent =
        c.surfaceCard.withAlpha(tokens.dimensions.transparentAlpha);
    switch (state) {
      case SldsComponentState.disabled:
        return _TagColors(
            c.disabledForeground, c.disabledBackground, c.disabledBackground);
      case SldsComponentState.error:
        return _TagColors(c.error, c.badgeErrorBackground, c.error);
      case SldsComponentState.success:
        return _TagColors(c.success, c.badgeSuccessBackground, c.success);
      case SldsComponentState.focus:
        return _TagColors(c.textPrimary, c.badgeNeutralBackground, c.focusRing);
      case SldsComponentState.active:
        return _TagColors(c.badgeInReviewText, c.badgeInReviewBackground,
            c.badgeInReviewText);
      case SldsComponentState.hover:
      case SldsComponentState.empty:
        return _TagColors(c.textPrimary, c.surfaceHover, c.borderDecorative);
      case SldsComponentState.loading:
        return _TagColors(
            c.badgePendingText, c.badgePendingBackground, c.badgePendingText);
      case SldsComponentState.defaultState:
      case null:
        return switch (type) {
          SldsBadgeType.success => _TagColors(
              c.badgeSuccessText, c.badgeSuccessBackground, transparent),
          SldsBadgeType.pending => _TagColors(
              c.badgePendingText, c.badgePendingBackground, transparent),
          SldsBadgeType.error ||
          SldsBadgeType.rejected =>
            _TagColors(c.badgeErrorText, c.badgeErrorBackground, transparent),
          SldsBadgeType.info =>
            _TagColors(c.badgeInfoText, c.badgeInfoBackground, transparent),
          SldsBadgeType.submitted => _TagColors(
              c.badgeSubmittedText, c.badgeSubmittedBackground, transparent),
          SldsBadgeType.inReview => _TagColors(
              c.badgeInReviewText, c.badgeInReviewBackground, transparent),
          SldsBadgeType.approved => _TagColors(
              c.badgeApprovedText, c.badgeApprovedBackground, transparent),
          SldsBadgeType.escalated => _TagColors(
              c.badgeEscalatedText, c.badgeEscalatedBackground, transparent),
          SldsBadgeType.onHold =>
            _TagColors(c.badgeOnHoldText, c.badgeOnHoldBackground, transparent),
          SldsBadgeType.neutral ||
          SldsBadgeType.draft ||
          SldsBadgeType.archived =>
            _TagColors(
                c.badgeNeutralText, c.badgeNeutralBackground, transparent),
        };
    }
  }
}
