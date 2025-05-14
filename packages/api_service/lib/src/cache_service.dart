import 'package:hive_flutter/hive_flutter.dart';

class CacheService {
  static const String _cacheBox = "api_cache";

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_cacheBox);
  }

  Future<void> storeData(String key, dynamic data, Duration expiry) async {
    final box = Hive.box(_cacheBox);
    final expiryTime = DateTime.now().add(expiry).millisecondsSinceEpoch;
    await box.put(key, {"data": data, "expiry": expiryTime});
  }

  dynamic getData(String key) {
    final box = Hive.box(_cacheBox);
    final cache = box.get(key);

    if (cache != null) {
      final expiry = cache["expiry"];
      if (DateTime.now().millisecondsSinceEpoch < expiry) {
        return cache["data"];
      } else {
        box.delete(key); // Remove expired cache
      }
    }
    return null;
  }

  Future<void> clearCache(String key) async {
    final box = Hive.box(_cacheBox);
    await box.delete(key);
  }
}
