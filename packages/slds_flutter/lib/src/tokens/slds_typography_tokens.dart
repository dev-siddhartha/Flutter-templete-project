import 'package:flutter/widgets.dart';

/// SLDS typography tokens.
///
/// English/Latin sizing only — this package is reused across products that
/// may support entirely different languages, so script-specific sizing
/// (e.g. reduced sizes for scripts with taller glyphs) is a consuming app's
/// responsibility, built on top of these tokens via [copyWith].
///
/// All styles are exposed as `final` fields so the class supports [copyWith].
/// To change the entire font family use [SldsTypographyTokens.withFontFamily].
class SldsTypographyTokens {
  /// Creates typography tokens. All styles default to the SLDS Alpha type
  /// scale using Google Sans.
  const SldsTypographyTokens({
    this.fontFamily = 'Google Sans',
    this.deckHeading1 = const TextStyle(
      fontFamily: 'Google Sans',
      fontSize: 88,
      height: 96 / 88,
      fontWeight: FontWeight.w700,
      letterSpacing: -5,
    ),
    this.deckHeading2 = const TextStyle(
      fontFamily: 'Google Sans',
      fontSize: 72,
      height: 80 / 72,
      fontWeight: FontWeight.w700,
      letterSpacing: -5,
    ),
    this.deckHeading3 = const TextStyle(
      fontFamily: 'Google Sans',
      fontSize: 56,
      height: 64 / 56,
      fontWeight: FontWeight.w700,
      letterSpacing: -4,
    ),
    this.deckHeading4 = const TextStyle(
      fontFamily: 'Google Sans',
      fontSize: 44,
      height: 52 / 44,
      fontWeight: FontWeight.w700,
      letterSpacing: -4,
    ),
    this.display1 = const TextStyle(
      fontFamily: 'Google Sans',
      fontSize: 36,
      height: 44 / 36,
      fontWeight: FontWeight.w700,
      letterSpacing: -2,
    ),
    this.display2 = const TextStyle(
      fontFamily: 'Google Sans',
      fontSize: 28,
      height: 36 / 28,
      fontWeight: FontWeight.w700,
      letterSpacing: -2,
    ),
    this.heading1 = const TextStyle(
      fontFamily: 'Google Sans',
      fontSize: 26,
      height: 28 / 26,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
    ),
    this.heading2 = const TextStyle(
      fontFamily: 'Google Sans',
      fontSize: 24,
      height: 32 / 24,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
    ),
    this.heading3 = const TextStyle(
      fontFamily: 'Google Sans',
      fontSize: 22,
      height: 36 / 22,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.5,
    ),
    this.heading4 = const TextStyle(
      fontFamily: 'Google Sans',
      fontSize: 20,
      height: 40 / 20,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.5,
    ),
    this.title1 = const TextStyle(
      fontFamily: 'Google Sans',
      fontSize: 18,
      height: 24 / 18,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
    ),
    this.body1 = const TextStyle(
      fontFamily: 'Google Sans',
      fontSize: 16,
      height: 20 / 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    ),
    this.body2 = const TextStyle(
      fontFamily: 'Google Sans',
      fontSize: 14,
      height: 24 / 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    ),
    this.caption1 = const TextStyle(
      fontFamily: 'Google Sans',
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    ),
    this.caption2 = const TextStyle(
      fontFamily: 'Google Sans',
      fontSize: 11,
      height: 20 / 11,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    ),
    this.overline = const TextStyle(
      fontFamily: 'Google Sans',
      fontSize: 11,
      height: 16 / 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 2,
    ),
    this.snackbarCaption = const TextStyle(
      fontFamily: 'Google Sans',
      fontSize: 12,
      height: 18 / 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 2,
    ),
    this.desktopTitle1 = const TextStyle(
      fontFamily: 'Google Sans',
      fontSize: 18,
      height: 28 / 18,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
    ),
    this.compactLabel = const TextStyle(
      fontFamily: 'Google Sans',
      fontSize: 16,
      height: 20 / 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
    ),
  });

  factory SldsTypographyTokens.withFontFamily(String fontFamily) {
    TextStyle style({
      required double fontSize,
      required double lineHeight,
      required FontWeight fontWeight,
      required double letterSpacing,
    }) =>
        TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          height: lineHeight / fontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
        );

    return SldsTypographyTokens(
      fontFamily: fontFamily,
      deckHeading1: style(
        fontSize: 88,
        lineHeight: 96,
        fontWeight: FontWeight.w700,
        letterSpacing: -5,
      ),
      deckHeading2: style(
        fontSize: 72,
        lineHeight: 80,
        fontWeight: FontWeight.w700,
        letterSpacing: -5,
      ),
      deckHeading3: style(
        fontSize: 56,
        lineHeight: 64,
        fontWeight: FontWeight.w700,
        letterSpacing: -4,
      ),
      deckHeading4: style(
        fontSize: 44,
        lineHeight: 52,
        fontWeight: FontWeight.w700,
        letterSpacing: -4,
      ),
      display1: style(
        fontSize: 36,
        lineHeight: 44,
        fontWeight: FontWeight.w700,
        letterSpacing: -2,
      ),
      display2: style(
        fontSize: 28,
        lineHeight: 36,
        fontWeight: FontWeight.w700,
        letterSpacing: -2,
      ),
      heading1: style(
        fontSize: 26,
        lineHeight: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ),
      heading2: style(
        fontSize: 24,
        lineHeight: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ),
      heading3: style(
        fontSize: 22,
        lineHeight: 36,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
      ),
      heading4: style(
        fontSize: 20,
        lineHeight: 40,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
      ),
      title1: style(
        fontSize: 18,
        lineHeight: 24,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
      ),
      body1: style(
        fontSize: 16,
        lineHeight: 20,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ),
      body2: style(
        fontSize: 14,
        lineHeight: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ),
      caption1: style(
        fontSize: 12,
        lineHeight: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ),
      caption2: style(
        fontSize: 11,
        lineHeight: 20,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ),
      overline: style(
        fontSize: 11,
        lineHeight: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 2,
      ),
      snackbarCaption: style(
        fontSize: 12,
        lineHeight: 18,
        fontWeight: FontWeight.w400,
        letterSpacing: 2,
      ),
      desktopTitle1: style(
        fontSize: 18,
        lineHeight: 28,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
      ),
      compactLabel: style(
        fontSize: 16,
        lineHeight: 20,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ),
    );
  }

  final String fontFamily;

  /// Hero/splash screens only — never in standard layouts.
  final TextStyle deckHeading1;

  /// Campaign headers only.
  final TextStyle deckHeading2;

  /// Large feature titles only.
  final TextStyle deckHeading3;

  /// Landing page section titles only.
  final TextStyle deckHeading4;

  /// Page-level display text.
  final TextStyle display1;

  /// Secondary page-level display text.
  final TextStyle display2;

  /// Main page heading.
  final TextStyle heading1;

  /// Section heading.
  final TextStyle heading2;

  /// Card heading.
  final TextStyle heading3;

  /// Sub-section heading.
  final TextStyle heading4;

  /// List item title, modal title.
  final TextStyle title1;

  /// Primary body copy — default for running paragraph text.
  final TextStyle body1;

  /// Longer body copy.
  final TextStyle body2;

  /// Helper text, form hints.
  final TextStyle caption1;

  /// Metadata, timestamps.
  final TextStyle caption2;

  /// Section labels — sentence case, never uppercased.
  final TextStyle overline;

  final TextStyle snackbarCaption;

  final TextStyle desktopTitle1;

  /// Compact-density component label.
  final TextStyle compactLabel;

  SldsTypographyTokens copyWith({
    String? fontFamily,
    TextStyle? deckHeading1,
    TextStyle? deckHeading2,
    TextStyle? deckHeading3,
    TextStyle? deckHeading4,
    TextStyle? display1,
    TextStyle? display2,
    TextStyle? heading1,
    TextStyle? heading2,
    TextStyle? heading3,
    TextStyle? heading4,
    TextStyle? title1,
    TextStyle? body1,
    TextStyle? body2,
    TextStyle? caption1,
    TextStyle? caption2,
    TextStyle? overline,
    TextStyle? snackbarCaption,
    TextStyle? desktopTitle1,
    TextStyle? compactLabel,
  }) =>
      SldsTypographyTokens(
        fontFamily: fontFamily ?? this.fontFamily,
        deckHeading1: deckHeading1 ?? this.deckHeading1,
        deckHeading2: deckHeading2 ?? this.deckHeading2,
        deckHeading3: deckHeading3 ?? this.deckHeading3,
        deckHeading4: deckHeading4 ?? this.deckHeading4,
        display1: display1 ?? this.display1,
        display2: display2 ?? this.display2,
        heading1: heading1 ?? this.heading1,
        heading2: heading2 ?? this.heading2,
        heading3: heading3 ?? this.heading3,
        heading4: heading4 ?? this.heading4,
        title1: title1 ?? this.title1,
        body1: body1 ?? this.body1,
        body2: body2 ?? this.body2,
        caption1: caption1 ?? this.caption1,
        caption2: caption2 ?? this.caption2,
        overline: overline ?? this.overline,
        snackbarCaption: snackbarCaption ?? this.snackbarCaption,
        desktopTitle1: desktopTitle1 ?? this.desktopTitle1,
        compactLabel: compactLabel ?? this.compactLabel,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SldsTypographyTokens &&
        other.fontFamily == fontFamily &&
        other.deckHeading1 == deckHeading1 &&
        other.deckHeading2 == deckHeading2 &&
        other.deckHeading3 == deckHeading3 &&
        other.deckHeading4 == deckHeading4 &&
        other.display1 == display1 &&
        other.display2 == display2 &&
        other.heading1 == heading1 &&
        other.heading2 == heading2 &&
        other.heading3 == heading3 &&
        other.heading4 == heading4 &&
        other.title1 == title1 &&
        other.body1 == body1 &&
        other.body2 == body2 &&
        other.caption1 == caption1 &&
        other.caption2 == caption2 &&
        other.overline == overline &&
        other.snackbarCaption == snackbarCaption &&
        other.desktopTitle1 == desktopTitle1 &&
        other.compactLabel == compactLabel;
  }

  @override
  int get hashCode => Object.hashAll([
        fontFamily,
        deckHeading1,
        deckHeading2,
        deckHeading3,
        deckHeading4,
        display1,
        display2,
        heading1,
        heading2,
        heading3,
        heading4,
        title1,
        body1,
        body2,
        caption1,
        caption2,
        overline,
        snackbarCaption,
        desktopTitle1,
        compactLabel,
      ]);
}
