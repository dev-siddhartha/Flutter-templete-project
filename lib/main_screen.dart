import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/core/cubits/theme_cubit/theme_cubit.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/core/utils/global_bloc_provider.dart';
import 'package:flutter_template/core/utils/theme/global_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.environment});

  final String environment;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: MediaQuery.of(context).size,
      minTextAdapt: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: GlobalBlocProvider().globalBlocProviders,
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, theme) {
              return AnimatedTheme(
                data: theme == ThemeMode.light
                    ? GlobalTheme.lightThemeData
                    : GlobalTheme.darkThemeData,
                duration: const Duration(milliseconds: 500),
                child: MaterialApp.router(
                  title: 'Siddhartha',
                  theme: GlobalTheme.lightThemeData,
                  darkTheme: GlobalTheme.darkThemeData,
                  routerConfig: RouteConfig.router,
                  themeMode: theme,
                  // home: MyHomePage(title: environment),
                ),
              );
            },
          ),
        );
      },
    );
  }
}


