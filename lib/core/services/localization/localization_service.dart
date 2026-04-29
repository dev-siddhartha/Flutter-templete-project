import 'package:flutter_template/core/utils/app_imports.dart';

enum AppLanguage { english, sinhala, tamil }

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
      case AppLanguage.sinhala:
        return const Locale('si');
      case AppLanguage.tamil:
        return const Locale('ta');
    }
  }

  String get label {
    switch (this) {
      case AppLanguage.english:
        return 'English';
      case AppLanguage.sinhala:
        return 'Sinhala';
      case AppLanguage.tamil:
        return 'Tamil';
    }
  }
}
