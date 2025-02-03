import 'package:flutter_template/core/utils/shared_preferences/shared_prefs_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: SharedPrefsService)
class SharedPrefsServiceImpl implements SharedPrefsService {
  final SharedPreferences _prefs;

  SharedPrefsServiceImpl(this._prefs);

  @override
  Future<void> setString({
    required String key,
    required String value,
  }) async {
    await _prefs.setString(key, value);
  }

  @override
  String? getString({
    required String key,
  }) {
    return _prefs.getString(key);
  }

  @override
  Future<void> setBool({
    required String key,
    required bool value,
  }) async {
    await _prefs.setBool(key, value);
  }

  @override
  bool? getBool({
    required String key,
  }) {
    return _prefs.getBool(key);
  }

  @override
  Future<void> setInt({
    required String key,
    required int value,
  }) async {
    await _prefs.setInt(key, value);
  }

  @override
  int? getInt({
    required String key,
  }) {
    return _prefs.getInt(key);
  }

  @override
  Future<void> setDouble({
    required String key,
    required double value,
  }) async {
    await _prefs.setDouble(key, value);
  }

  @override
  double? getDouble({
    required String key,
  }) {
    return _prefs.getDouble(key);
  }

  @override
  Future<void> setStringList({
    required String key,
    required List<String> value,
  }) async {
    await _prefs.setStringList(key, value);
  }

  @override
  List<String>? getStringList({
    required String key,
  }) {
    return _prefs.getStringList(key);
  }

  @override
  void removeKey({required String key}) async {
    await _prefs.remove(key);
  }

  @override
  Future<Set<String>> getAllKey() async {
    return _prefs.getKeys();
  }

  @override
  void clearSharedPrefsData() async {
    await _prefs.clear();
  }
}
