import 'package:slds_flutter/slds_flutter.dart';

/// The project's brand color palette, injected into slds_flutter's
/// [SldsTheme] so every SLDS component picks it up automatically.
///
/// [SldsPalette.defaultPalette] is already ported 1:1 from `AppColors`
/// (name and value), so this is currently a passthrough. Rebrand by
/// overriding swatches here with `.copyWith(...)`, e.g. after editing
/// `AppColors` for a new project, or to diverge from it without touching
/// the shared `slds_flutter` package.
class AppPalette {
  AppPalette._();

  static const SldsPalette palette = SldsPalette.defaultPalette;
}
