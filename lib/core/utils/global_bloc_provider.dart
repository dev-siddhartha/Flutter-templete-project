import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/core/cubits/language_cubit/language_cubit.dart';
import 'package:flutter_template/core/cubits/theme_cubit/theme_cubit.dart';
import 'package:flutter_template/injectable/injectable.dart';
import 'package:nested/nested.dart';

interface class IGloblaBlocProvider {
  List<SingleChildWidget> get globalBlocProviders => [
        BlocProvider.value(
          value: getIt<ThemeCubit>()..getThemeFromPreference(),
        ),
        BlocProvider.value(
          value: getIt<LanguageCubit>()..persistLanguageChange(),
        )
      ];
}

class GlobalBlocProvider extends IGloblaBlocProvider {}
