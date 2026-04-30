import 'package:flutter_template/core/utils/app_imports.dart';

/// Supported application languages used for localization and locale resolution.
///
/// Each value maps directly to a Flutter [Locale] via [AppLanguageX.locale].
///
/// WARNING:
/// - Adding a new language requires updating:
///   - locale mapping in [AppLanguageX]
///   - label mapping in [AppLanguageX]
///   - supported assets / arb files
enum AppLanguage {
  english,
  nepali,
  arabic,
}

/// Provides localization-related utilities for the application.
///
/// Responsibilities:
/// - Maps [AppLanguage] to Flutter [Locale]
/// - Exposes supported language list
///
/// This is a stateless utility service and does not persist user selection.
///
/// NOTE:
/// - It does NOT manage persistence (SharedPreferences / secure storage)
/// - It does NOT trigger locale changes in app state
@lazySingleton
class LocalizationService {
  /// Converts an [AppLanguage] into a Flutter [Locale].
  ///
  /// This is a direct mapping using [AppLanguageX.locale].
  Locale getLocale(AppLanguage language) {
    return language.locale;
  }

  /// List of all supported application languages.
  ///
  /// Derived directly from enum values.
  /// WARNING: ordering depends on enum declaration order.
  List<AppLanguage> get supportedLanguages => AppLanguage.values;
}

/// Shortcut accessor for localization strings.
///
/// Returns the generated [AppLocalizations] instance from context.
///
/// WARNING:
/// - This will throw if localization is not initialized in widget tree
/// - Assumes non-null localization binding (`!` operator used)
AppLocalizations l10(BuildContext context) => AppLocalizations.of(context)!;

/// Extension utilities for [AppLanguage].
///
/// Provides:
/// - Locale mapping for Flutter localization system
/// - Human-readable display labels for UI
///
/// IMPORTANT:
/// - Every new enum value MUST update both `locale` and `label`
///   or you will silently break UI consistency.
extension AppLanguageX on AppLanguage {
  /// Maps [AppLanguage] to a Flutter [Locale].
  ///
  /// Used by MaterialApp / CupertinoApp locale configuration.
  Locale get locale {
    switch (this) {
      case AppLanguage.english:
        return const Locale('en');
      case AppLanguage.nepali:
        return const Locale('ne');
      case AppLanguage.arabic:
        return const Locale('ar');
    }
  }

  /// Human-readable display name for UI.
  ///
  /// Used in language selectors and settings screens.
  String get label {
    switch (this) {
      case AppLanguage.english:
        return 'English';
      case AppLanguage.nepali:
        return 'Nepali';
      case AppLanguage.arabic:
        return 'Arabic';
    }
  }
}
