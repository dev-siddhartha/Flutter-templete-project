import 'package:flutter_template/core/utils/app_imports.dart';

@lazySingleton
class LocalizationService {
  AppLocalizations? get appLocalization =>
      AppLocalizations.of(getIt<NavigationService>().getNavigationContext());
}

AppLocalizations l10(BuildContext context) => AppLocalizations.of(context)!;
