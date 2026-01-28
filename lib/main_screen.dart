import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/core/cubits/language_cubit/language_cubit.dart';
import 'package:flutter_template/core/cubits/theme_cubit/theme_cubit.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/core/utils/global_bloc_provider.dart';
import 'package:flutter_template/core/utils/theme/global_theme.dart';
import 'package:flutter_template/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.environment});

  final String environment;

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
              return BlocBuilder<LanguageCubit, Locale>(
                builder: (context, language) {
                  return BlocListener<AuthCubit, bool>(
                    listener: (context, auth) {
                      if (auth) {
                        getIt<NavigationService>()
                            .pushAndRemoveUntil(RouteNames.dashboardRoute);
                      } else {
                        getIt<NavigationService>()
                            .pushAndRemoveUntil(RouteNames.loginRoute);
                      }
                    },
                    child: AnimatedTheme(
                      data: theme == ThemeMode.light
                          ? GlobalTheme.lightThemeData
                          : GlobalTheme.darkThemeData,
                      duration: const Duration(milliseconds: 500),
                      child: MaterialApp.router(
                        builder: FToastBuilder(),
                        debugShowCheckedModeBanner: false,
                        title: 'Siddhartha',
                        theme: GlobalTheme.lightThemeData,
                        darkTheme: GlobalTheme.darkThemeData,
                        routerConfig: RouteConfig.router,
                        themeMode: theme,
                        localizationsDelegates:
                            AppLocalizations.localizationsDelegates,
                        supportedLocales: AppLocalizations.supportedLocales,
                        locale: language,
                        // home: MyHomePage(title: environment),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
