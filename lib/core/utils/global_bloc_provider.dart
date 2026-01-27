import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/core/cubits/language_cubit/language_cubit.dart';
import 'package:flutter_template/core/cubits/theme_cubit/theme_cubit.dart';
import 'package:flutter_template/features/dashboard/presentation/bloc/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:flutter_template/injectable/injectable.dart';
import 'package:nested/nested.dart';

interface class ICoreBlocProvider {
  List<SingleChildWidget> get coreBlocProviders => [
        BlocProvider.value(
          value: getIt<ThemeCubit>()..getThemeFromPreference(),
        ),
        BlocProvider.value(
          value: getIt<LanguageCubit>()..persistLanguageChange(),
        ),
      ];
}

interface class IMiscBlocProvider {
  List<SingleChildWidget> get miscBlocProviders => [
        BlocProvider.value(
          value: getIt<BottomNavCubit>(),
        ),
      ];
}

interface class IGloblaBlocProvider {
  List<SingleChildWidget> get globalBlocProviders => [
        ...ICoreBlocProvider().coreBlocProviders,
        ...IMiscBlocProvider().miscBlocProviders,
      ];
}

class GlobalBlocProvider extends IGloblaBlocProvider {}
