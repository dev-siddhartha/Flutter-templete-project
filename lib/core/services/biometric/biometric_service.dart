abstract class BiometricService {
  /// Whether the device has biometrics enrolled and available to use.
  Future<bool> isBiometricAvailable();

  /// Prompts the OS biometric UI. Returns false on failure/cancel instead of throwing.
  Future<bool> authenticate({String reason = 'Please authenticate to continue'});
}
