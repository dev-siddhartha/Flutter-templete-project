import 'package:flutter_template/core/services/network_service/network_service.dart';
import 'package:flutter_template/core/type_defs.dart';
import 'package:flutter_template/core/utils/app_imports.dart';

import '../../domain/repo/auth_repo.dart';

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
        "expiresInMin": 10,
      },
    );
  }

  @override
  FutureDynamicFailure getProfile() async {
    return getIt<NetworkService>().apiRequest(
      endpoint: profile,
      method: RequestMethod.get,
    );
  }
}
