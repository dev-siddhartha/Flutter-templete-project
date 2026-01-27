import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/core/initial_app_mixin.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/core/utils/logger/app_logger.dart';
import 'package:flutter_template/core/widgets/app_exit_alert.dart';
import 'package:flutter_template/features/dashboard/data/constants/dashboard_constants.dart';
import 'package:flutter_template/features/dashboard/presentation/bloc/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:flutter_template/features/dashboard/presentation/widgets/bottom_nav_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    _fetchApiAccordingToNav(BottomNavString.home);
  }

  void _fetchApiAccordingToNav(String key) {
    switch (key) {
      case BottomNavString.home:
        if (!getIt<InitialAppMixin>()
            .visitedBottomNavBar
            .contains(BottomNavString.home)) {
          getIt<InitialAppMixin>()
              .visitedBottomNavBar
              .add(BottomNavString.home);
          getIt<InitialAppMixin>().fetchHomeInitialData();
        }
        break;

      case BottomNavString.history:
        if (!getIt<InitialAppMixin>()
            .visitedBottomNavBar
            .contains(BottomNavString.history)) {
          getIt<InitialAppMixin>()
              .visitedBottomNavBar
              .add(BottomNavString.history);
          getIt<InitialAppMixin>().fetchHistoryInitialData();
        }
        break;

      case BottomNavString.profile:
        if (!getIt<InitialAppMixin>()
            .visitedBottomNavBar
            .contains(BottomNavString.profile)) {
          getIt<InitialAppMixin>()
              .visitedBottomNavBar
              .add(BottomNavString.profile);
          getIt<InitialAppMixin>().fetchProfileInitialData();
        }
        break;

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavCubit, List<String>>(
      listener: (context, tabHistory) {
        final String currentScreen = tabHistory.last;
        AppLogger.debug('Tab history: ${tabHistory.toString()}');
        _fetchApiAccordingToNav(currentScreen);
      },
      builder: (context, tabHistory) {
        final String currentKey = tabHistory.last;
        final int currentIndex =
            DashboardConstants().screenMap.keys.toList().indexOf(currentKey);

        return AppExitAlert(
          isToDisplayExitMessage: currentKey == BottomNavString.home,
          optionalWillPopFunction: () {
            if (tabHistory.length > 1) {
              AppLogger.debug('Tab history on back: ${tabHistory.toString()}');
              getIt<BottomNavCubit>().goBack();
            }
          },
          child: Scaffold(
            bottomNavigationBar: BottomNavWidget(
              currentIndex: currentIndex,
              onTabSelected: (index) {
                final key = DashboardConstants().screenMap.keys.toList()[index];

                getIt<BottomNavCubit>().updateScreen(key);
              },
            ),
            body: IndexedStack(
              index: currentIndex,
              children: DashboardConstants().screenMap.values.toList(),
            ),
          ),
        );
      },
    );
  }
}
