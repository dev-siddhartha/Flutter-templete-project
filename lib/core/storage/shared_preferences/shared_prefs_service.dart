abstract class SharedPrefsService {
  Future<void> setString({
    required String key,
    required String value,
  });

  String? getString({
    required String key,
  });

  Future<void> setBool({
    required String key,
    required bool value,
  });

  bool? getBool({
    required String key,
  });

  Future<void> setInt({
    required String key,
    required int value,
  });

  int? getInt({
    required String key,
  });

  Future<void> setDouble({
    required String key,
    required double value,
  });

  double? getDouble({
    required String key,
  });
  Future<void> setStringList({
    required String key,
    required List<String> value,
  });

  List<String>? getStringList({
    required String key,
  });

  void removeKey({required String key});

  Future<Set<String>> getAllKey();

  void clearSharedPrefsData();
}
