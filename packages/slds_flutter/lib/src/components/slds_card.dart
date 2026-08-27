import 'package:flutter/material.dart';

import '../styles/slds_card_style.dart';
import '../theme/slds_theme.dart';
import 'slds_focus.dart';
import 'slds_state.dart';

/// SLDS card variants.
enum SldsCardVariant {
  /// Bordered card.
  defaultCard,

  /// Elevated card.
  elevated,
}

/// Semantic role for [SldsCard].
enum SldsCardSemanticsRole {
  /// Purely presentational card. No extra semantic node is added.
  none,

  /// Card acts as a semantic grouping container/region.
  container,

  /// Entire card acts like a tappable button surface.
  button,
}

/// Figma-backed SLDS card.
///
/// This widget can be used as:
/// - a purely presentational card
/// - a semantic grouping container
/// - a tappable button-like card
class SldsCard extends StatelessWidget {
  /// Creates an SLDS Card.
  const SldsCard({
    super.key,
    this.child,
    this.variant = SldsCardVariant.defaultCard,
    this.width,
    this.height,
    this.state,
    this.style,
    this.semanticRole = SldsCardSemanticsRole.none,
    this.semanticLabel,
    this.excludeChildSemantics = false,
    this.onTap,
    this.boxShadow,
  }) : assert(
          semanticRole != SldsCardSemanticsRole.button || onTap != null,
          'SldsCard: semanticRole=button requires a non-null onTap callback.',
        );

  final Widget? child;

  final SldsCardVariant variant;

  final double? width;

  final double? height;

  final SldsComponentState? state;

  final SldsCardStyle? style;

  /// Semantic role of this card.
  ///
  /// - [none]: purely visual wrapper, no extra semantic node
  /// - [container]: grouped semantic region
  /// - [button]: tappable card exposed as a button
  final SldsCardSemanticsRole semanticRole;

  /// Optional semantic label for the card.
  ///
  /// Recommended when [semanticRole] is not [SldsCardSemanticsRole.none].
  final String? semanticLabel;

  /// Whether to suppress child semantics and expose only this card node.
  final bool excludeChildSemantics;

  final VoidCallback? onTap;

  /// Applied only when [variant == SldsCardVariant.elevated]
  final List<BoxShadow>? boxShadow;

  bool get _disabled =>
      state == SldsComponentState.disabled ||
      state == SldsComponentState.loading;

  bool get _isInteractive =>
      semanticRole == SldsCardSemanticsRole.button &&
      onTap != null &&
      !_disabled;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final elevated = variant == SldsCardVariant.elevated;

    final background = style?.backgroundColor ??
        (_disabled
            ? tokens.colors.disabledBackground
            : state == SldsComponentState.hover
                ? tokens.colors.surfaceHover
                : tokens.colors.surfaceCard);

    final border = style?.borderColor ?? _borderColor(context, state);

    final shadow = [
      if (state == SldsComponentState.focus) ...sldsFocusRing(tokens),
      if (elevated)
        ...(boxShadow ??
            [
              BoxShadow(
                color: tokens.colors.textPrimary.withAlpha(
                  tokens.dimensions.elevationAlpha,
                ),
                blurRadius: tokens.dimensions.cardShadowBlur,
                offset: Offset(
                  tokens.dimensions.space0,
                  tokens.dimensions.cardShadowOffsetY,
                ),
              ),
            ]),
    ];

    final radius = style?.borderRadius ?? tokens.dimensions.radius2xl;
    final cardPadding =
        style?.padding ?? EdgeInsets.all(tokens.dimensions.space16);
    final shape = style?.shape ?? BoxShape.rectangle;
    // BoxDecoration asserts borderRadius is null when shape is a circle.
    final borderRadius =
        shape == BoxShape.circle ? null : BorderRadius.circular(radius);

    // With a gradient, layer background color and gradient as separate
    // fills (BoxDecoration only ever paints one of color/gradient) so the
    // gradient can sit on top of the color, e.g. for semi-transparent stops.
    Widget card = style?.gradient != null
        ? Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              shape: shape,
              borderRadius: borderRadius,
              border: border == null ? null : Border.all(color: border),
              boxShadow: shadow.isEmpty ? null : shadow,
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: background,
                      shape: shape,
                      borderRadius: borderRadius,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: style?.gradient,
                      shape: shape,
                      borderRadius: borderRadius,
                    ),
                  ),
                ),
                Padding(padding: cardPadding, child: child),
              ],
            ),
          )
        : Container(
            width: width,
            height: height,
            padding: cardPadding,
            decoration: BoxDecoration(
              color: background,
              shape: shape,
              borderRadius: borderRadius,
              border: border == null ? null : Border.all(color: border),
              boxShadow: shadow.isEmpty ? null : shadow,
            ),
            child: child,
          );

    // If the whole card is interactive, make the entire surface tappable.
    if (semanticRole == SldsCardSemanticsRole.button) {
      card = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isInteractive ? onTap : null,
          borderRadius: BorderRadius.circular(radius),
          child: card,
        ),
      );
    }

    final shouldWrapSemantics = semanticRole != SldsCardSemanticsRole.none ||
        semanticLabel != null ||
        excludeChildSemantics;

    if (!shouldWrapSemantics) {
      return card;
    }

    return Semantics(
      container: semanticRole == SldsCardSemanticsRole.container,
      button: semanticRole == SldsCardSemanticsRole.button,
      enabled: semanticRole == SldsCardSemanticsRole.button ? !_disabled : null,
      label: semanticLabel,
      excludeSemantics: excludeChildSemantics,
      child: card,
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
        return variant == SldsCardVariant.elevated
            ? null
            : colors.borderDecorative;
    }
  }
}
