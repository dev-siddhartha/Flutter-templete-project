// ignore_for_file: public_member_api_docs
import 'package:flutter/widgets.dart';

/// A single color swatch supporting shade access like Material Color swatches.
///
/// Access by shade: `swatch[50]`, `swatch[100]`, `swatch[500]`, etc.
/// Call the instance directly for the default shade.
class SldsColorSwatch extends ColorSwatch<int> {
  /// The default shade used when no key is provided.
  final int defaultShade;

  /// Creates a color swatch.
  const SldsColorSwatch(this.defaultShade, Map<int, Color> swatch)
      : super(defaultShade, swatch);

  @override
  Color operator [](int key) => super[key]!;

  /// Returns the default shade.
  Color call() => this[defaultShade];
}

/// Raw color swatches for the SLDS design system.
///
/// The palette is the lowest layer of the 3-layer token system:
///   1. [SldsPalette]       — raw swatches, shades 50–900 per group
///   2. [SldsColorScheme]   — semantic mappings that reference palette shades
///   3. [SldsTokenSet]      — full token set consumed by components
///
/// Changing a palette shade automatically updates every semantic token that
/// references it across all themes.
///
/// Field names mirror the project's own color naming (`primary`, `secondary`,
/// `success`, `error`, `grey`, `warning`, `info`) so a project's color file
/// maps onto this palette 1:1 by name, not just by value.
///
/// Example — rebrand primary for a new app:
/// ```dart
/// SldsTheme(
///   data: SldsTokenSet.light(
///     palette: SldsPalette.defaultPalette.copyWith(
///       primary: SldsColorSwatch(
///         500,
///         {
///           50: Color(0xFFEEF7FF),
///           100: Color(0xFFDCEFFF),
///           // ... etc
///         },
///       ),
///     ),
///   ),
///   child: app,
/// )
/// ```
class SldsPalette {
  /// Creates a color palette. All swatches are required.
  const SldsPalette({
    required this.primary,
    required this.secondary,
    required this.success,
    required this.error,
    required this.grey,
    required this.warning,
    required this.info,
  });

  // ── Primary (brand) ─────────────────────────────────────────────────────

  /// [50]–[900] brand color.
  final SldsColorSwatch primary;

  // ── Secondary (brand accent) ────────────────────────────────────────────

  /// [50]–[900] secondary brand accent.
  final SldsColorSwatch secondary;

  // ── Success (approved / positive) ───────────────────────────────────────

  /// [50]–[900] success feedback, approved status, positive indicators.
  final SldsColorSwatch success;

  // ── Error (destructive / negative) ──────────────────────────────────────

  /// [50]–[900] error feedback, rejected status, destructive actions.
  final SldsColorSwatch error;

  // ── Grey (UI structure) ─────────────────────────────────────────────────

  /// [50]–[900] neutral scale for text, surfaces, borders.
  final SldsColorSwatch grey;

  // ── Warning (escalated / caution) ───────────────────────────────────────

  /// [50]–[900] warning feedback, escalated status, attention indicators.
  final SldsColorSwatch warning;

  // ── Info (informational / submitted) ────────────────────────────────────

  /// [50]–[900] informational feedback, submitted status.
  final SldsColorSwatch info;

  // ── Default palette ─────────────────────────────────────────────────────

  /// The template's default color palette.
  ///
  /// Ported 1:1 (name and value) from the app layer's `AppColors`. A project
  /// with different brand colors should override swatches via [copyWith]
  /// rather than editing this file, keeping this package reusable across
  /// template clones.
  static const SldsPalette defaultPalette = SldsPalette(
    primary: SldsColorSwatch(
      500,
      {
        50: Color(0xFFE6F9F5),
        100: Color(0xFFB0EBE1),
        200: Color(0xFF8AE2D3),
        300: Color(0xFF54D4BF),
        400: Color(0xFF33CCB2),
        500: Color(0xFF00BF9F),
        600: Color(0xFF00AE91),
        700: Color(0xFF008871),
        800: Color(0xFF006957),
        900: Color(0xFF005043),
      },
    ),

    secondary: SldsColorSwatch(
      500,
      {
        50: Color(0xFFE6F9F5),
        100: Color(0xFFB0EBE1),
        200: Color(0xFF8AE2D3),
        300: Color(0xFF54D4BF),
        400: Color(0xFF33CCB2),
        500: Color(0xFF00BF9F),
        600: Color(0xFF00AE91),
        700: Color(0xFF008871),
        800: Color(0xFF006957),
        900: Color(0xFF005043),
      },
    ),

    success: SldsColorSwatch(
      500,
      {
        50: Color(0xFFE9F9EF),
        100: Color(0xFFBAEDCD),
        200: Color(0xFF99E4B5),
        300: Color(0xFF6BD893),
        400: Color(0xFF4ED17E),
        500: Color(0xFF22C55E),
        600: Color(0xFF1FB356),
        700: Color(0xFF188C43),
        800: Color(0xFF136C34),
        900: Color(0xFF0E5327),
      },
    ),

    error: SldsColorSwatch(
      500,
      {
        50: Color(0xFFFBEAE8),
        100: Color(0xFFF3BEB8),
        200: Color(0xFFED9E95),
        300: Color(0xFFE57265),
        400: Color(0xFFE05647),
        500: Color(0xFFD82C19),
        600: Color(0xFFC52817),
        700: Color(0xFF991F12),
        800: Color(0xFF77180E),
        900: Color(0xFF5B120B),
      },
    ),

    grey: SldsColorSwatch(
      500,
      {
        50: Color(0xFFF6F7F8),
        100: Color(0xFFF8F9FA),
        200: Color(0xFFE9ECEF),
        300: Color(0xFFDEE2E6),
        400: Color(0xFFCED4DA),
        500: Color(0xFFADB5BD),
        600: Color(0xFF6C755D),
        700: Color(0xFF495057),
        800: Color(0xFF343A40),
        900: Color(0xFF212529),
      },
    ),

    warning: SldsColorSwatch(
      500,
      {
        50: Color(0xFFFFFFEA),
        100: Color(0xFFFFF3CD),
        200: Color(0xFFFFE69C),
        300: Color(0xFFFFDA6A),
        400: Color(0xFFFFCD39),
        500: Color(0xFFFFC107),
        600: Color(0xFFCC9A06),
        700: Color(0xFF997404),
        800: Color(0xFF664D03),
        900: Color(0xFF332701),
      },
    ),

    info: SldsColorSwatch(
      500,
      {
        50: Color(0xFFEDFFFC),
        100: Color(0xFFCFF4FC),
        200: Color(0xFF9EEAF9),
        300: Color(0xFF6EDFF6),
        400: Color(0xFF3DD5F3),
        500: Color(0xFF0DCAF0),
        600: Color(0xFF0AA2C0),
        700: Color(0xFF087990),
        800: Color(0xFF055160),
        900: Color(0xFF032830),
      },
    ),
  );

  // ── copyWith ───────────────────────────────────────────────────────────────

  /// Returns a copy with the given swatches replaced.
  SldsPalette copyWith({
    SldsColorSwatch? primary,
    SldsColorSwatch? secondary,
    SldsColorSwatch? success,
    SldsColorSwatch? error,
    SldsColorSwatch? grey,
    SldsColorSwatch? warning,
    SldsColorSwatch? info,
  }) =>
      SldsPalette(
        primary: primary ?? this.primary,
        secondary: secondary ?? this.secondary,
        success: success ?? this.success,
        error: error ?? this.error,
        grey: grey ?? this.grey,
        warning: warning ?? this.warning,
        info: info ?? this.info,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SldsPalette &&
        other.primary == primary &&
        other.secondary == secondary &&
        other.success == success &&
        other.error == error &&
        other.grey == grey &&
        other.warning == warning &&
        other.info == info;
  }

  @override
  int get hashCode =>
      Object.hashAll([primary, secondary, success, error, grey, warning, info]);
}
