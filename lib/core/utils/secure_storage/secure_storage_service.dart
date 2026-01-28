abstract class SecureStorageService {
  Future<void> writeSecureData({required String key, required String value});
  Future<String?> readSecureData({required String key});
  Future<void> deleteSecureData({required String key});
  Future<void> deleteAllSecureData();
  /// Forcefully clear tokens that may have been stored with different iOS options
  /// (e.g., with iCloud sync enabled). This is useful for migration.
  Future<void> forceClearToken({required String key});
}
