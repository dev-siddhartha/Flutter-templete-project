/// Barrel file for the SLDS token layer.
///
/// The 3-layer token system:
///   1. [SldsPalette]       — raw swatches (50–1000 per group)
///   2. [SldsColorScheme]   — semantic mappings that reference palette shades
///   3. [SldsTokenSet]      — full token set consumed by components
///
/// Split by concern into individual files (color/dimension/typography/motion
/// + the combining [SldsTokenSet]) for maintainability; re-exported here so
/// existing imports of `slds_tokens.dart` keep working unchanged.
library;

export 'slds_color_tokens.dart';
export 'slds_dimension_tokens.dart';
export 'slds_motion_tokens.dart';
export 'slds_token_set.dart';
export 'slds_typography_tokens.dart';
