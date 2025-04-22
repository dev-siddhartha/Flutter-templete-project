class ApiConstants {
  ApiConstants._internal();

  /// for response
  static const String invalidCredentials = "INVALID_CREDENTIAL";
  static const String deviceNotVerified = "DEVICE_NOT_REGISTERED";
  static const String duplicateData = "DUPLICATE_DATA";
  static const String biometricError = "BIOMETRIC_ERROR";

  /// for api headers
  static const String xClientType = "MOBILE";
  static const String clientId = "mobile-client";
  static const String accept = "application/json";
}
