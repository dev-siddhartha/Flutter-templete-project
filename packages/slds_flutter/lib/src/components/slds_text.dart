import 'package:flutter/widgets.dart';

import '../theme/slds_theme.dart';
import '../tokens/slds_tokens.dart';

/// SLDS typography variants, mapped 1:1 to [SldsTypographyTokens]'s fields —
/// same names as the Figma variables the tokens were captured from, so
/// picking a variant here is a direct lookup, not a translation.
enum SldsTextVariant {
  /// Hero/splash screens only — never in standard layouts.
  deckHeading1,

  /// Campaign headers only.
  deckHeading2,

  /// Large feature titles only.
  deckHeading3,

  /// Landing page section titles only.
  deckHeading4,

  /// Page-level display text.
  display1,

  /// Secondary page-level display text.
  display2,

  /// Main page heading — largest of the four heading steps.
  heading1,

  /// Section heading.
  heading2,

  /// Card heading.
  heading3,

  /// Sub-section heading — smallest of the four heading steps.
  heading4,

  /// List item title, modal title.
  title1,

  /// Primary body copy — default for running paragraph text.
  body1,

  /// Longer body copy.
  body2,

  /// Helper text, form hints.
  caption1,

  /// Metadata, timestamps.
  caption2,

  /// Section labels — sentence case, never uppercased.
  overline,

  /// Snackbar component only.
  snackbarCaption,

  /// Desktop-scaled title.
  desktopTitle1,

  /// Compact-density component label.
  compactLabel,
}

/// Token-bound text widget for SLDS typography.
/// Renders using the active [SldsTokenSet]'s typography scale so text
class SldsText extends StatelessWidget {
  /// Creates an SLDS text widget.
  const SldsText(
    this.data, {
    super.key,
    this.variant = SldsTextVariant.body1,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.height,
    this.fontStyle,
    this.decoration,
    this.fontFamily,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.textScaler,
    this.softWrap,
    this.semanticsLabel,
  });

  final String data;

  /// SLDS typography variant. Ignored when [style] is provided.
  final SldsTextVariant variant;

  /// Optional color override. When null, falls back to any color already
  /// set on [style], then the ambient `DefaultTextStyle` — so text dropped
  /// into a themed ancestor (e.g. an [SldsButton]'s disabled/enabled
  /// foreground) picks up its color automatically, same as a plain [Text]
  /// with no explicit style would.
  final Color? color;

  /// Overrides the variant's font size.
  final double? fontSize;

  /// Overrides the variant's font weight.
  final FontWeight? fontWeight;

  /// Overrides the variant's letter spacing.
  final double? letterSpacing;

  /// Overrides the variant's line-height multiplier.
  final double? height;

  /// Overrides the variant's font style (e.g. italic).
  final FontStyle? fontStyle;

  /// Overrides the variant's text decoration (e.g. underline).
  final TextDecoration? decoration;

  /// Overrides the variant's font family.
  final String? fontFamily;

  /// Full style override. When provided, [variant] is ignored as the base —
  /// the individual `fontSize`/`fontWeight`/etc. overrides below are still
  /// layered on top of it.
  final TextStyle? style;

  final TextAlign? textAlign;

  final int? maxLines;

  final TextOverflow? overflow;

  /// Text scaling strategy.
  final TextScaler? textScaler;

  /// Whether the text should break at soft line breaks.
  final bool? softWrap;

  /// Screen reader label. When null, [data] is used.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final tokens = context.slds;
    final baseStyle = style ?? _resolve(tokens.typography, variant);
    final effectiveStyle = baseStyle.copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
      fontStyle: fontStyle,
      decoration: decoration,
      fontFamily: fontFamily,
    );

    final effectiveColor = color ?? effectiveStyle.color;
    return Text(
      data,
      locale: Localizations.maybeLocaleOf(context),
      style: effectiveStyle.copyWith(
          color: effectiveColor, decorationColor: effectiveColor),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      textScaler: textScaler,
      softWrap: softWrap,
      semanticsLabel: semanticsLabel,
    );
  }

  static TextStyle _resolve(SldsTypographyTokens t, SldsTextVariant variant) {
    switch (variant) {
      case SldsTextVariant.deckHeading1:
        return t.deckHeading1;
      case SldsTextVariant.deckHeading2:
        return t.deckHeading2;
      case SldsTextVariant.deckHeading3:
        return t.deckHeading3;
      case SldsTextVariant.deckHeading4:
        return t.deckHeading4;
      case SldsTextVariant.display1:
        return t.display1;
      case SldsTextVariant.display2:
        return t.display2;
      case SldsTextVariant.heading1:
        return t.heading1;
      case SldsTextVariant.heading2:
        return t.heading2;
      case SldsTextVariant.heading3:
        return t.heading3;
      case SldsTextVariant.heading4:
        return t.heading4;
      case SldsTextVariant.title1:
        return t.title1;
      case SldsTextVariant.body1:
        return t.body1;
      case SldsTextVariant.body2:
        return t.body2;
      case SldsTextVariant.caption1:
        return t.caption1;
      case SldsTextVariant.caption2:
        return t.caption2;
      case SldsTextVariant.overline:
        return t.overline;
      case SldsTextVariant.snackbarCaption:
        return t.snackbarCaption;
      case SldsTextVariant.desktopTitle1:
        return t.desktopTitle1;
      case SldsTextVariant.compactLabel:
        return t.compactLabel;
    }
  }
}
