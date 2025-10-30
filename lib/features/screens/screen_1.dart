import 'package:flutter_template/core/constants/environment_config.dart';
import 'package:flutter_template/core/cubits/language_cubit/language_cubit.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/core/utils/localization/localization_support.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final ValueNotifier<String> _selectedLanguage = ValueNotifier('English');

  @override
  void initState() {
    super.initState();
    _selectedLanguage.value = lang();
  }

  @override
  void dispose() {
    _selectedLanguage.dispose();
    super.dispose();
  }

  String lang() {
    final lang =
        getIt<SharedPrefsService>().getString(key: SharedPrefsKeys.lang);
    switch (lang) {
      case 'en':
        return 'English';
      case 'ne':
        return 'Nepali';
      case 'ar':
        return 'Arabic';
      default:
        return 'English';
    }
  }

  void _changeLanguage(String language) {
    String langCode;
    switch (language) {
      case 'English':
        langCode = 'en';
        break;
      case 'Nepali':
        langCode = 'ne';
        break;
      case 'Arabic':
        langCode = 'ar';
        break;
      default:
        langCode = 'en';
    }

    getIt<SharedPrefsService>()
        .setString(key: SharedPrefsKeys.lang, value: langCode);
    final locale = getIt<LocalizationSupport>().getLocale(language);
    getIt<LanguageCubit>().changeLocale(locale);
    _selectedLanguage.value = language;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(EnvironmentConfig.appEnvironment),
        actions: [
          _buildChangeLanguage(),
          10.horizontalSpace,
        ],
      ),
      body: Center(
        child: TextWidget(AppLocalizations.of(context)!.ac_created).onTap(() {
          getIt<NavigationService>().navigateTo(RouteNames.screen2);
        }),
      ),
    );
  }

  Widget _buildChangeLanguage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 6.r),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: AppColors.whiteColor.withValues(alpha: .1),
        ),
      ),
      child: ValueListenableBuilder(
        valueListenable: _selectedLanguage,
        builder: (_, selectedLanguage, __) {
          return DropdownButton<String>(
            value: selectedLanguage,
            dropdownColor: AppColors.blackColor,
            isDense: true,
            underline: const SizedBox.shrink(),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.whiteColor,
            ),
            onChanged: (value) {
              if (value != null) {
                _changeLanguage(value);
                _selectedLanguage.value = value;
              }
            },
            items: getIt<LocalizationSupport>()
                .langList
                .map(
                  (lang) => DropdownMenuItem<String>(
                    value: lang,
                    child: TextWidget(
                      lang,
                      color: AppColors.whiteColor,
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
