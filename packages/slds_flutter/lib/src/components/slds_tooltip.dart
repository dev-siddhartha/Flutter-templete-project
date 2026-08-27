import 'package:flutter/material.dart';

import '../styles/slds_tooltip_style.dart';
import '../theme/slds_theme.dart';
import 'slds_button.dart';
import 'slds_state.dart';

/// Tooltip content variants from Figma.
enum SldsTooltipVariant {
  /// Title only.
  title,

  /// Title and description.
  titleDescription,

  /// Title, description, progress detail and action.
  action,
}

/// Figma-backed SLDS tooltip.
class SldsTooltip extends StatelessWidget {
  /// Creates an SLDS tooltip.
  const SldsTooltip({
    super.key,
    required this.title,
    this.description,
    this.detail,
    this.actionLabel,
    this.onAction,
    this.onClose,
    this.variant = SldsTooltipVariant.titleDescription,
    this.state,
    this.style,
  });

  final String title;

  final String? description;

  /// e.g. "1 of 5".
  final String? detail;

  final String? actionLabel;

  final VoidCallback? onAction;

  /// Shown only for [SldsTooltipVariant.action]. When null, the close icon
  /// is purely decorative — pass a callback to make it interactive.
  final VoidCallback? onClose;

  final SldsTooltipVariant variant;

  final SldsComponentState? state;

  /// Visual style overrides. Null fields inherit from the active [SldsTokenSet].
  final SldsTooltipStyle? style;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final tooltipColors = _TooltipStyle.resolve(context, state);
    final titleOnly = variant == SldsTooltipVariant.title;
    final effectiveBg = style?.backgroundColor ?? tooltipColors.background;
    final effectiveFg = style?.foregroundColor ?? tooltipColors.text;
    final effectiveBr = style?.borderRadius ?? tokens.dimensions.radiusXl;
    final effectivePadding = style?.padding ??
        EdgeInsets.symmetric(
          horizontal: tokens.dimensions.space12,
          vertical:
              titleOnly ? tokens.dimensions.space8 : tokens.dimensions.space12,
        );
    return Semantics(
      liveRegion: true,
      label: title,
      child: Container(
        width: titleOnly
            ? tokens.dimensions.tooltipTitleWidth
            : tokens.dimensions.tooltipWidth,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: tokens.colors.textPrimary.withAlpha(
                tokens.dimensions.space24.toInt(),
              ),
              blurRadius: tokens.dimensions.space6,
              spreadRadius: -tokens.dimensions.space1,
              offset:
                  Offset(tokens.dimensions.space0, tokens.dimensions.space4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPaint(
              size: Size(
                tokens.dimensions.tooltipArrowWidth,
                tokens.dimensions.tooltipArrowHeight,
              ),
              painter: _TooltipArrowPainter(effectiveBg),
            ),
            Container(
              width: double.infinity,
              padding: effectivePadding,
              decoration: BoxDecoration(
                color: effectiveBg,
                borderRadius: BorderRadius.circular(effectiveBr),
                border: Border.all(color: tooltipColors.border),
              ),
              child: DefaultTextStyle.merge(
                style: tokens.typography.caption1.copyWith(color: effectiveFg),
                child: titleOnly
                    ? _titleOnly(context)
                    : _rich(context, effectiveFg),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleOnly(BuildContext context) {
    return Text(
      title,
      locale: Localizations.maybeLocaleOf(context),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _rich(BuildContext context, Color effectiveFg) {
    final tokens = context.slds;
    final titleStyle = style?.titleStyle ??
        tokens.typography.title1.copyWith(color: effectiveFg);
    final descStyle = style?.descriptionStyle ??
        tokens.typography.caption1.copyWith(color: effectiveFg);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                locale: Localizations.maybeLocaleOf(context),
                style: titleStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (variant == SldsTooltipVariant.action)
              onClose == null
                  ? Icon(Icons.close,
                      size: tokens.dimensions.iconSizeMedium,
                      color: effectiveFg)
                  : Semantics(
                      button: true,
                      label: MaterialLocalizations.of(context).closeButtonLabel,
                      child: GestureDetector(
                        excludeFromSemantics: true,
                        onTap: onClose,
                        child: Icon(Icons.close,
                            size: tokens.dimensions.iconSizeMedium,
                            color: effectiveFg),
                      ),
                    ),
          ],
        ),
        if (description != null) ...[
          SizedBox(height: tokens.dimensions.space2),
          Text(
            description!,
            locale: Localizations.maybeLocaleOf(context),
            style: descStyle,
          ),
        ],
        if (variant == SldsTooltipVariant.action) ...[
          SizedBox(height: tokens.dimensions.space8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (detail != null)
                Text(
                  detail!,
                  style:
                      tokens.typography.caption1.copyWith(color: effectiveFg),
                ),
              if (actionLabel != null)
                SldsButton(
                  size: SldsButtonSize.small,
                  variant: SldsButtonVariant.secondary,
                  onPressed: onAction,
                  child: Text(actionLabel!),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _TooltipArrowPainter extends CustomPainter {
  const _TooltipArrowPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_TooltipArrowPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _TooltipStyle {
  const _TooltipStyle({
    required this.background,
    required this.text,
    required this.border,
  });

  final Color background;
  final Color text;
  final Color border;

  static _TooltipStyle resolve(
      BuildContext context, SldsComponentState? state) {
    final tokens = context.slds;
    final c = tokens.colors;
    final transparent =
        c.tooltipBackground.withAlpha(tokens.dimensions.transparentAlpha);
    switch (state) {
      case SldsComponentState.error:
        return _TooltipStyle(
            background: c.error,
            text: c.buttonDestructiveLabel,
            border: c.error);
      case SldsComponentState.success:
        return _TooltipStyle(
            background: c.success, text: c.tooltipText, border: c.success);
      case SldsComponentState.disabled:
        return _TooltipStyle(
            background: c.disabledBackground,
            text: c.disabledForeground,
            border: c.disabledBackground);
      case SldsComponentState.focus:
        return _TooltipStyle(
            background: c.tooltipBackground,
            text: c.tooltipText,
            border: c.focusRing);
      case SldsComponentState.loading:
        return _TooltipStyle(
            background: c.warning, text: c.textPrimary, border: c.warning);
      case SldsComponentState.hover:
      case SldsComponentState.active:
      case SldsComponentState.empty:
      case SldsComponentState.defaultState:
      case null:
        return _TooltipStyle(
            background: c.tooltipBackground,
            text: c.tooltipText,
            border: transparent);
    }
  }
}
