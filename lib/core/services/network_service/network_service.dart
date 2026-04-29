import 'package:api_request_handler/api_service.dart';
import 'package:flutter_template/core/storage/cache/file/file_cache_config.dart';
import 'package:flutter_template/core/storage/cache/hive/hive_keys.dart';
import 'package:flutter_template/core/type_defs.dart';
export 'package:dio/dio.dart';
export 'package:api_request_handler/api_service.dart';

abstract class NetworkService {
  Future<void> initilizeNetworkService();

  FutureDynamicFailure apiRequest<T>({
    required String endpoint,
    required RequestMethod method,
    Map<String, dynamic>? params,

    /// either a [Map<String, dynamic>] or a [FormData] instance
    Object? data,
    Map<String, String>? headers,
    String? contentType,
    Duration? cacheDuration,
    bool forceRefresh = true,

    /// for third party urls
    bool isThirdParty = false,
    String? thirdPartyBaseUrl,
  });

  FutureDynamicFailure handleCacheableRequest({
    required FutureDynamicFailure Function() apiCall,
    required String cacheKey,
    required HiveBoxes box,
    Duration ttl = const Duration(hours: 24),
    FileCacheConfig? fileConfig,
  });
}
