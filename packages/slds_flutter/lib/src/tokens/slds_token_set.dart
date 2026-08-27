import 'slds_color_tokens.dart';
import 'slds_dimension_tokens.dart';
import 'slds_motion_tokens.dart';
import 'slds_palette.dart';
import 'slds_typography_tokens.dart';

/// Combined SLDS token set for a mode.
class SldsTokenSet {
  SldsTokenSet({
    required this.colors,
    required this.palette,
    SldsDimensionTokens? dimensions,
    this.typography = const SldsTypographyTokens(),
    required this.motion,
  }) : dimensions = dimensions ?? SldsDimensionTokens();

  final SldsColorScheme colors;

  final SldsPalette palette;

  /// Primary (brand) color swatch.
  SldsColorSwatch get primary => palette.primary;

  /// Secondary (brand accent) color swatch.
  SldsColorSwatch get secondary => palette.secondary;

  /// Success (approved/positive) color swatch.
  SldsColorSwatch get success => palette.success;

  /// Error (destructive/negative) color swatch.
  SldsColorSwatch get error => palette.error;

  /// Grey (UI structure) color swatch.
  SldsColorSwatch get grey => palette.grey;

  /// Warning (escalated/caution) color swatch.
  SldsColorSwatch get warning => palette.warning;

  /// Info (informational/submitted) color swatch.
  SldsColorSwatch get info => palette.info;

  final SldsDimensionTokens dimensions;

  final SldsTypographyTokens typography;

  final SldsMotionTokens motion;

  /// Light mode token set. Optionally supply a custom [palette] to rebrand.
  factory SldsTokenSet.light({
    SldsPalette palette = SldsPalette.defaultPalette,
    bool reducedMotion = false,
  }) =>
      SldsTokenSet(
        colors: SldsColorScheme.light(palette),
        palette: palette,
        motion: SldsMotionTokens(reducedMotion: reducedMotion),
      );

  /// Dark mode token set. Optionally supply a custom [palette] to rebrand.
  factory SldsTokenSet.dark({
    SldsPalette palette = SldsPalette.defaultPalette,
    bool reducedMotion = false,
  }) =>
      SldsTokenSet(
        colors: SldsColorScheme.dark(palette),
        palette: palette,
        motion: SldsMotionTokens(reducedMotion: reducedMotion),
      );

  /// High contrast token set. Optionally supply a custom [palette] to rebrand.
  factory SldsTokenSet.highContrast({
    SldsPalette palette = SldsPalette.defaultPalette,
    bool reducedMotion = false,
  }) =>
      SldsTokenSet(
        colors: SldsColorScheme.highContrast(palette),
        palette: palette,
        motion: SldsMotionTokens(reducedMotion: reducedMotion),
      );

  SldsTokenSet copyWith({
    SldsColorScheme? colors,
    SldsPalette? palette,
    SldsDimensionTokens? dimensions,
    SldsTypographyTokens? typography,
    SldsMotionTokens? motion,
  }) =>
      SldsTokenSet(
        colors: colors ?? this.colors,
        palette: palette ?? this.palette,
        dimensions: dimensions ?? this.dimensions,
        typography: typography ?? this.typography,
        motion: motion ?? this.motion,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SldsTokenSet &&
        other.colors == colors &&
        other.palette == palette &&
        other.dimensions == dimensions &&
        other.typography == typography &&
        other.motion == motion;
  }

  @override
  int get hashCode =>
      Object.hashAll([colors, palette, dimensions, typography, motion]);
}
