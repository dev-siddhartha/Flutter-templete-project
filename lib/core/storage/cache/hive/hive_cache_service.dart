import 'package:flutter_template/core/storage/hive_keys.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:hive/hive.dart';

@singleton
class HiveCacheService {

  
  //! modify this every time you add a new box
  Box _getBox(HiveBoxes box) {
    switch (box) {
      case HiveBoxes.user:
        return Hive.box(HiveBoxes.user.name);
      case HiveBoxes.drivingLicense:
        return Hive.box(HiveBoxes.drivingLicense.name);
      case HiveBoxes.revenueLicense:
        return Hive.box(HiveBoxes.revenueLicense.name);
      case HiveBoxes.insuranceCertificate:
        return Hive.box(HiveBoxes.insuranceCertificate.name);
      case HiveBoxes.emissionCertificate:
        return Hive.box(HiveBoxes.emissionCertificate.name);
      case HiveBoxes.secure:
        return Hive.box(HiveBoxes.secure.name);
    }
  }

  Future<void> save({
    required HiveBoxes boxType,
    required String key,
    required Map<String, dynamic> value,
    required Duration ttl,
  }) async {
    final box = _getBox(boxType);

    final expiry = DateTime.now().add(ttl).millisecondsSinceEpoch;

    await box.put(key, {
      'data': value,
      'expiry': expiry,
    });
  }

  Map<String, dynamic>? get({
    required HiveBoxes boxType,
    required String key,
  }) {
    final box = _getBox(boxType);
    final item = box.get(key);

    if (item == null || item is! Map) return null;

    final expiry = item['expiry'];
    if (expiry is! int) return null;

    if (DateTime.now().millisecondsSinceEpoch > expiry) {
      box.delete(key);
      return null;
    }

    final data = item['data'];
    if (data is! Map) return null;

    return Map<String, dynamic>.from(data);
  }

  Future<void> clearBox(HiveBoxes boxType) async {
    await _getBox(boxType).clear();
  }

  Future<void> clearKey({
    required HiveBoxes boxType,
    required String key,
  }) async {
    await _getBox(boxType).delete(key);
  }
}
