import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class SecureStorageModule {
  @lazySingleton
  FlutterSecureStorage get secureprefs {
    const iosOptions = IOSOptions(
      synchronizable:
          false, // Disable iCloud sync to prevent persistence issues
    );

    // Configure Android options
    const androidOptions = AndroidOptions();

    return const FlutterSecureStorage(
      aOptions: androidOptions,
      iOptions: iosOptions,
    );
  }
}
