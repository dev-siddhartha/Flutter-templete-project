import 'dart:convert';

import 'package:flutter_template/core/constants/secured_storage_keys.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/core/utils/logger/app_logger.dart';
import 'package:flutter_template/core/utils/secure_storage/secure_storage_service.dart';
import 'package:flutter_template/features/auth/domain/model/token_model.dart';
import 'package:flutter_template/features/profile/domain/model/profile_model.dart';
import 'package:flutter_template/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

ProfileModel? getCurrentUser() {
  String? encodedProfile =
      getIt<SharedPrefsService>().getString(key: SharedPrefsKeys.userProfile);

  ProfileModel? cachedProfile;

  if (encodedProfile != null) {
    cachedProfile = ProfileModel.fromJson(json.decode(encodedProfile));
  }

  ProfileModel? currentUser =
      getIt<ProfileBloc>().state.detailState.data ?? cachedProfile;
  return currentUser;
}

class AuthService {
  final SecureStorageService _secureStorage = getIt<SecureStorageService>();
  final SharedPrefsService _sharedPrefs = getIt<SharedPrefsService>();

  /// Store tokens securely in secure storage
  Future<void> storeTokens(TokenModel tokenModel) async {
    try {
      // Store in secure storage
      if (tokenModel.accessToken != null &&
          tokenModel.accessToken!.isNotEmpty) {
        await _secureStorage.writeSecureData(
          key: SecureStorageKeys.accessToken,
          value: tokenModel.accessToken!,
        );
      }

      if (tokenModel.refreshToken != null &&
          tokenModel.refreshToken!.isNotEmpty) {
        await _secureStorage.writeSecureData(
          key: SecureStorageKeys.refreshToken,
          value: tokenModel.refreshToken!,
        );
      }
    } catch (e) {
      AppLogger.error('Error storing tokens: $e', error: e);
      rethrow;
    }
  }

  /// Get token model from secure storage
  /// Falls back to SharedPrefs during migration period
  Future<TokenModel?> getToken() async {
    try {
      // Try secure storage first
      final accessToken = await _secureStorage.readSecureData(
        key: SecureStorageKeys.accessToken,
      );
      final refreshToken = await _secureStorage.readSecureData(
        key: SecureStorageKeys.refreshToken,
      );

      if (accessToken != null || refreshToken != null) {
        return TokenModel(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
      }

      return null;
    } catch (e) {
      AppLogger.error('Error getting token: $e', error: e);
      return null;
    }
  }

  /// Get refresh token from secure storage
  Future<String> getRefreshToken() async {
    final tokenModel = await getToken();
    return tokenModel?.refreshToken ?? "";
  }

  /// Get access token from secure storage
  /// This is used in API interceptor - must be async now
  Future<String> getAccessToken() async {
    final tokenModel = await getToken();
    return tokenModel?.accessToken ?? "";
  }

  /// Clear all user data on logout
  Future<void> clearUserProfile() async {
    try {
      _secureStorage.deleteSecureData(key: SecureStorageKeys.accessToken);
      _secureStorage.deleteSecureData(key: SecureStorageKeys.refreshToken);

      final accessToken = await _secureStorage.readSecureData(
        key: SecureStorageKeys.accessToken,
      );
      final refreshToken = await _secureStorage.readSecureData(
        key: SecureStorageKeys.refreshToken,
      );

      if (accessToken != null || refreshToken != null) {
        AppLogger.warning(
          'Tokens still exist after deletion. AccessToken: ${accessToken != null}, RefreshToken: ${refreshToken != null}',
        );
        if (accessToken != null) {
          await _secureStorage.deleteSecureData(
              key: SecureStorageKeys.accessToken);
        }
        if (refreshToken != null) {
          await _secureStorage.deleteSecureData(
              key: SecureStorageKeys.refreshToken);
        }
      } else {
        AppLogger.info('Successfully cleared all user tokens');
      }
    } catch (e) {
      AppLogger.error('Error clearing user profile: $e', error: e);
      rethrow;
    }
  }

  /// Store user profile (can stay in SharedPrefs as it's not sensitive)
  void storeUserProfile(ProfileModel profileModel) {
    String userProfile = json.encode(profileModel);
    _sharedPrefs.setString(
      key: SharedPrefsKeys.userProfile,
      value: userProfile,
    );
  }
}
