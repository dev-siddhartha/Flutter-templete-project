import 'package:flutter_template/core/services/biometric/biometric_service.dart';
import 'package:flutter_template/core/utils/logger/app_logger.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

@LazySingleton(as: BiometricService)
class BiometricServiceImpl extends BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  Future<bool> isBiometricAvailable() async {
    try {
      final canCheckBiometrics = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      return canCheckBiometrics && isDeviceSupported;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to check biometric availability',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  @override
  Future<bool> authenticate({
    String reason = 'Please authenticate to continue',
  }) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: reason,
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'Biometric authentication failed',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }
}
