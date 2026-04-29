import 'package:flutter_template/core/services/network_service/network_service.dart';
import 'package:flutter_template/core/storage/cache/file/file_cache_config.dart';
import 'package:flutter_template/core/type_defs.dart';
import 'package:flutter_template/core/utils/app_imports.dart';

import '../../../core/storage/cache/hive/hive_keys.dart';
import 'auth_repo.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  static const String auth = "auth";
  static const String login = "$auth/login";
  static const String profile = "$auth/me";

  @override
  FutureDynamicFailure loginUser(
      {required String username, required String password}) async {
    return getIt<NetworkService>().apiRequest(
      endpoint: login,
      method: RequestMethod.post,
      data: {
        "username": username,
        "password": password,
        "expiresInMin": 1,
      },
    );
  }

  @override
  FutureDynamicFailure getProfile() async {
    return getIt<NetworkService>().handleCacheableRequest(
      apiCall: () => getIt<NetworkService>().apiRequest(
        endpoint: profile,
        method: RequestMethod.get,
      ),
      box: HiveBoxes.user,
      cacheKey: HiveKeys.profile,
      ttl: const Duration(minutes: 1),
      fileConfig: const FileCacheConfig(
        [
          FileField(key: 'image', localKey: 'localImage'),
        ],
      ),
    );
  }
}
