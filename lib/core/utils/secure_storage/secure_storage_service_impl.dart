import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/core/utils/logger/app_logger.dart';
import 'package:flutter_template/core/utils/secure_storage/secure_storage_service.dart';

@LazySingleton(as: SecureStorageService)
class SecureStorageServiceImpl implements SecureStorageService {
  final FlutterSecureStorage _secureStorage;

  SecureStorageServiceImpl(this._secureStorage);

  @override
  Future<void> deleteAllSecureData() async {
    try {
      await _secureStorage.deleteAll();
      AppLogger.info('All secure data deleted successfully');
    } catch (e) {
      AppLogger.error('Error deleting all secure data: $e', error: e);
      rethrow;
    }
  }

  @override
  Future<void> deleteSecureData({required String key}) async {
    try {
      // On iOS, deletion can be unreliable. Using a more robust approach:
      // 1. First, writing an empty string to overwrite any existing value
      // 2. Then deleting the key
      // 3. Verifying deletion by reading back (should return null)

      if (Platform.isIOS) {
        // Step 1: Overwriting with empty string
        await _secureStorage.write(key: key, value: '');

        // Step 2: Deleting the key
        await _secureStorage.delete(key: key);

        // Step 3: Verifying deletion - trying to read back
        final verifyValue = await _secureStorage.read(key: key);
        if (verifyValue != null && verifyValue.isNotEmpty) {
          // If still exists, trying to delete again with all options
          AppLogger.warning(
              'Token still exists after deletion for key: $key, attempting force delete');
          await _secureStorage.delete(
              key: key,
              aOptions: const AndroidOptions(),
              iOptions: const IOSOptions());

          // Final verifying
          final finalValue = await _secureStorage.read(key: key);
          if (finalValue != null && finalValue.isNotEmpty) {
            AppLogger.error(
                'Failed to delete secure data for key: $key. Value still exists: ${finalValue.substring(0, finalValue.length > 20 ? 20 : finalValue.length)}...');
            throw Exception('Failed to delete secure data for key: $key');
          }
        }
        AppLogger.info('Successfully deleted secure data for key: $key');
      } else {
        // For Android, standard deletion
        await _secureStorage.delete(key: key);
        AppLogger.info('Successfully deleted secure data for key: $key');
      }
    } catch (e) {
      AppLogger.error('Error deleting secure data for key $key: $e', error: e);
      rethrow;
    }
  }

  @override
  Future<String?> readSecureData({required String key}) async {
    try {
      final value = await _secureStorage.read(key: key);
      // On iOS, if we get an empty string, treating it as null (deleted)
      if (value != null && value.isEmpty) {
        AppLogger.warning(
            'Found empty string for key: $key, treating as deleted');
        return null;
      }
      return value;
    } catch (e) {
      AppLogger.error('Error reading secure data for key $key: $e', error: e);
      return null;
    }
  }

  @override
  Future<void> writeSecureData(
      {required String key, required String value}) async {
    try {
      await _secureStorage.write(key: key, value: value);
      AppLogger.info('Successfully wrote secure data for key: $key');
    } catch (e) {
      AppLogger.error('Error writing secure data for key $key: $e', error: e);
      rethrow;
    }
  }

  @override
  Future<void> forceClearToken({required String key}) async {
    if (!Platform.isIOS) {
      // For Android, use standard deletion
      await deleteSecureData(key: key);
      return;
    }

    try {
      AppLogger.info(
          'Force clearing token for key: $key (trying all iOS options)');

      // Try deleting with synchronizable: false (current config)
      await _secureStorage.delete(
        key: key,
        iOptions: const IOSOptions(synchronizable: false),
      );

      // Try deleting with synchronizable: true (old config with iCloud sync)
      await _secureStorage.delete(
        key: key,
        iOptions: const IOSOptions(synchronizable: true),
      );

      // Overwrite with empty string using both options
      await _secureStorage.write(
        key: key,
        value: '',
        iOptions: const IOSOptions(synchronizable: false),
      );
      await _secureStorage.write(
        key: key,
        value: '',
        iOptions: const IOSOptions(synchronizable: true),
      );

      // Delete again with both options
      await _secureStorage.delete(
        key: key,
        iOptions: const IOSOptions(synchronizable: false),
      );
      await _secureStorage.delete(
        key: key,
        iOptions: const IOSOptions(synchronizable: true),
      );

      // Verify deletion
      final verifyValue1 = await _secureStorage.read(
        key: key,
        iOptions: const IOSOptions(synchronizable: false),
      );
      final verifyValue2 = await _secureStorage.read(
        key: key,
        iOptions: const IOSOptions(synchronizable: true),
      );

      if ((verifyValue1 != null && verifyValue1.isNotEmpty) ||
          (verifyValue2 != null && verifyValue2.isNotEmpty)) {
        AppLogger.warning(
          'Token still exists after force clear for key: $key. '
          'sync=false: ${verifyValue1 != null && verifyValue1.isNotEmpty}, '
          'sync=true: ${verifyValue2 != null && verifyValue2.isNotEmpty}',
        );
      } else {
        AppLogger.info('Successfully force cleared token for key: $key');
      }
    } catch (e) {
      AppLogger.error('Error force clearing token for key $key: $e', error: e);
    }
  }
}
