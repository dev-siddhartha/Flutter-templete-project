import 'dart:convert';

import 'package:flutter_template/core/storage/hive_keys.dart';
import 'package:flutter_template/core/storage/secure_storage/secure_storage_service.dart';
import 'package:flutter_template/core/storage/secured_storage_keys.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@singleton
class HiveInitializer {
  final SecureStorageService secureStorage;

  HiveInitializer(this.secureStorage);

  //! call this method only at the start of the app [i.e entry point]
  //! only modify if need to open more boxes
  Future<void> init() async {
    await Hive.initFlutter();

    // normal boxes
    await Hive.openBox(HiveBoxes.user.name);
    await Hive.openBox(HiveBoxes.drivingLicense.name);
    await Hive.openBox(HiveBoxes.revenueLicense.name);
    await Hive.openBox(HiveBoxes.insuranceCertificate.name);
    await Hive.openBox(HiveBoxes.emissionCertificate.name);

    // encrypted box
    final key = await _getEncryptionKey();

    await Hive.openBox(
      HiveBoxes.secure.name,
      encryptionCipher: HiveAesCipher(key),
    );
  }

  Future<List<int>> _getEncryptionKey() async {
    var key =
        await secureStorage.readSecureData(key: SecureStorageKeys.hiveKey);

    if (key == null) {
      final newKey = Hive.generateSecureKey();
      await secureStorage.writeSecureData(
        key: SecureStorageKeys.hiveKey,
        value: base64UrlEncode(newKey),
      );
      return newKey;
    }

    return base64Url.decode(key);
  }
}
