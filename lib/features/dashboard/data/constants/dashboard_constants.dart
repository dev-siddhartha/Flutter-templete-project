import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/features/history/presentation/screens/history_screen.dart';
import 'package:flutter_template/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_template/features/profile/presentation/screens/profile_screen.dart';

class DashboardConstants {
  final Map<String, Widget> screenMap = {
    BottomNavString.home: const HomeScreen(),
    BottomNavString.history: const HistoryScreen(),
    BottomNavString.profile: const ProfileScreen(),
  };
}

class BottomNavString {
  static const String home = "Home";
  static const String history = "History";
  static const String profile = "Profile";
}
