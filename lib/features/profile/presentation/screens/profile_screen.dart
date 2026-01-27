import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/core/cubits/language_cubit/language_cubit.dart';
import 'package:flutter_template/core/cubits/theme_cubit/theme_cubit.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/core/utils/localization/localization_service.dart';
import 'package:flutter_template/core/utils/localization/localization_support.dart';
import 'package:flutter_template/core/widgets/app_bar_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  void _changeTheme() {
    getIt<ThemeCubit>().changeTheme(
      getIt<ThemeCubit>().state == ThemeMode.light ? 'Dark' : 'Light',
    );
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
      appBar: AppBarWidget(
        title: l10(context).profile,
      ),
      body: ScreenPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildThemeSection(),
            _buildLanguageSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSection() {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return SwitchListTile(
          title: const TextWidget('Dark Mode', textType: TextType.bodyLarge),
          value: state == ThemeMode.dark,
          onChanged: (value) {
            _changeTheme();
          },
          inactiveTrackColor: AppColors.grey[300],
          inactiveThumbColor: AppColors.grey[500],
        );
      },
    );
  }

  Widget _buildLanguageSection() {
    return ListTile(
      title: TextWidget(
        l10(context).language,
        textType: TextType.bodyLarge,
      ),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 6.r),
        decoration: BoxDecoration(
          color: context.isDark ? AppColors.whiteColor : AppColors.blackColor,
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
              dropdownColor:
                  context.isDark ? AppColors.whiteColor : AppColors.blackColor,
              isDense: true,
              underline: const SizedBox.shrink(),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: context.isDark
                    ? AppColors.blackColor
                    : AppColors.whiteColor,
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
                        color: context.isDark
                            ? AppColors.blackColor
                            : AppColors.whiteColor,
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
