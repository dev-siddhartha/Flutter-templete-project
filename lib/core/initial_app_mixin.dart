import 'package:flutter_template/core/utils/app_imports.dart';

@lazySingleton
class InitialAppMixin {
  List<String> visitedBottomNavBar = [];

  /// call when app is initialized
  void fetchAppInitialData() {}

  /// call when user is logged in
  void fetchLoggedInInitialData() {}

  void fetchHomeInitialData() {}

  void fetchHistoryInitialData() {}

  void fetchProfileInitialData() {}
}
