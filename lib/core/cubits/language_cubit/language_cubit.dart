import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'dart:ui';

@lazySingleton
class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('en')); // Provide a default
  // LanguageCubit(super.initialState);
  void changeLocale(Locale newLocale) async {
    await getIt<SharedPrefsService>()
        .setString(key: SharedPrefsKeys.lang, value: newLocale.languageCode);
    emit(newLocale);
  }

  //persist the change
  void persistLanguageChange() async {
    String? selectedLang =
        getIt<SharedPrefsService>().getString(key: SharedPrefsKeys.lang);
    if (selectedLang != null && selectedLang.isNotEmpty) {
      emit(Locale(selectedLang));
    }
  }
}
