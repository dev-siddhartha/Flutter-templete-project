import 'package:flutter_template/core/cubits/theme_cubit/theme_cubit.dart';
import 'package:flutter_template/core/utils/app_imports.dart';

class ThemeWidget extends StatefulWidget {
  const ThemeWidget({super.key});

  @override
  State<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> {
  ValueNotifier<String> selectedtheme = ValueNotifier<String>('Light');

  List<String> themes = ['Light', 'Dark', 'System'];

  @override
  void initState() {
    super.initState();

    selectedtheme.value = theme();
  }

  String theme() {
    final theme =
        getIt<SharedPrefsService>().getString(key: SharedPrefsKeys.theme);
    return theme ?? 'Light';
  }

  void _changeTheme(String theme) {
    getIt<ThemeCubit>().changeTheme(theme);
  }

  void _themeChangeFunction() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 15.h,
              children: [
                20.verticalSpace,
                const TextWidget(
                  "Select Theme",
                  textType: TextType.title,
                ),
                10.verticalSpace,
                ValueListenableBuilder(
                  valueListenable: selectedtheme,
                  builder: (context, value, child) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: themes.length,
                      itemBuilder: (context, index) {
                        final theme = themes[index];
                        return ScreenPadding(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: TextWidget(theme),
                            onTap: () {
                              _changeTheme(theme);
                              selectedtheme.value = theme;
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenPadding(
      child: Column(
        spacing: 15.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
            "Theme",
            textType: TextType.title,
          ),
          Row(
            children: [
              10.horizontalSpace,
              const TextWidget(
                "Select Theme",
              ),
              const Spacer(),
              ValueListenableBuilder(
                valueListenable: selectedtheme,
                builder: (context, value, child) {
                  return TextWidget(value);
                },
              ),
              8.horizontalSpace,
              Icon(
                Icons.arrow_forward_ios,
                size: 16.r,
              )
            ],
          ).onTap(
            () => _themeChangeFunction(),
          ),
        ],
      ),
    );
  }
}
