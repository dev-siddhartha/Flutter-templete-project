import 'package:flutter_template/core/utils/app_imports.dart';

enum AppLanguage {
  english,
  nepali,
  arabic,
}

@lazySingleton
class LocalizationService {
  Locale getLocale(AppLanguage language) {
    return language.locale;
  }

  List<AppLanguage> get supportedLanguages => AppLanguage.values;
}

AppLocalizations l10(BuildContext context) => AppLocalizations.of(context)!;

extension AppLanguageX on AppLanguage {
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
