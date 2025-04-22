
import 'package:flutter_template/core/utils/app_imports.dart';

@lazySingleton
class LocalizationSupport {
  List<String> langList = [
    'English',
    'Nepali',
    'Arabic',
  ];

  Locale getLocale(String lang) {
    switch (lang) {
      case 'English':
        return const Locale('en');
      case 'Nepali':
        return const Locale('ne');
      case 'Arabic':
        return const Locale('ar');
      default:
        return const Locale('en');
    }
  }

  List<PopupMenuEntry<String>> getLanguageList() {
    return langList
        .map((lang) => PopupMenuItem<String>(
              value: lang,
              child: TextWidget(lang),
            ))
        .toList();
  }
}
