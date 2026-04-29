import 'dart:convert';

import 'package:flutter_template/core/services/network_service/network_service.dart';
import 'package:flutter_template/core/storage/cache/file_cache_service.dart';
import 'package:flutter_template/core/storage/cache/local_cache_service.dart';
import 'package:flutter_template/core/type_defs.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:fpdart/fpdart.dart';

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

  // @override
  // FutureDynamicFailure getProfile() async {
  //   return getIt<NetworkService>().apiRequest(
  //     endpoint: profile,
  //     method: RequestMethod.get,
  //   );
  // }
  @override
  FutureDynamicFailure getProfile() async {
    try {
      final response = await getIt<NetworkService>().apiRequest(
        endpoint: profile,
        method: RequestMethod.get,
      );

      return await response.fold((l) async {
        if (l != null) {
          final data = Map<String, dynamic>.from(l);

          //  cache files
          if (data['data']['image'] != null) {
            final path =
                await getIt<FileCacheService>().cacheFile(data['data']['image']);
            data['data']['local_image'] = path;
          }

          //  cache JSON
          await getIt<LocalCacheService>().save(
            key: 'user:profile',
            json: jsonEncode(data),
            ttl: const Duration(minutes: 1),
          );

          return Left(data); //  ALWAYS fresh
        } else {
          throw Exception("Invalid data");
        }
      }, (r) async {
        // API failed → fallback
        final cached = await getIt<LocalCacheService>().get('user:profile');

        if (cached != null) {
          return Left(jsonDecode(cached));
        }

        return Right(r);
      });
    } catch (_) {
      // network crash / offline
      final cached = await getIt<LocalCacheService>().get('user:profile');

      if (cached != null) {
        return Left(jsonDecode(cached));
      }

      rethrow;
    }
  }
}
