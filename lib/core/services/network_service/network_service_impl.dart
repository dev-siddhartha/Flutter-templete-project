import 'package:flutter_template/core/storage/cache/file/file_cache_config.dart';
import 'package:flutter_template/core/storage/cache/file/file_cache_service.dart';
import 'package:flutter_template/core/storage/cache/hive/hive_cache_service.dart';
import 'package:flutter_template/core/storage/hive_keys.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_template/core/constants/api_constants.dart';
import 'package:flutter_template/core/constants/environment_config.dart';
import 'package:flutter_template/core/model/device_info_model.dart';
import 'package:flutter_template/core/model/failure_model.dart';
import 'package:flutter_template/core/services/device_info/device_info_service.dart';
import 'package:flutter_template/core/services/network_service/api_interceptor.dart';
import 'package:flutter_template/core/services/network_service/network_service.dart';
import 'package:flutter_template/core/type_defs.dart';
import 'package:flutter_template/core/utils/app_imports.dart';

@LazySingleton(as: NetworkService)
class NetworkServiceImpl extends NetworkService {
  @override
  Future<void> initilizeNetworkService() async {
    final DeviceInfoModel deviceInforService =
        await DeviceInfoService.getDeviceInfo();

    Map<String, String> globalHeaders = {
      "X-Device-Token": deviceInforService.deviceFingerPrint,
      "X-Client-Type": ApiConstants.xClientType,
      "client_id": ApiConstants.clientId,
      "Accept": ApiConstants.accept,
    };

    await ApiRequest().initialize(
      baseUrl: EnvironmentConfig.baseUrl,
      globalHeaders: globalHeaders,
      interceptors: [
        TokenInterceptor(),
      ],
    );
  }

  @override
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
  }) async {
    // Ensure 'data' is either a [Map<String, dynamic>] or a [FormData] instance
    assert(
      data == null || data is Map<String, dynamic> || data is FormData,
      'data must be either Map<String, dynamic> or FormData',
    );

    Map<String, String> header = {...?headers};

    try {
      final response = await ApiRequest().request(
        endpoint: endpoint,
        method: method,
        data: data,
        params: params,
        headers: header,
        contentType: contentType,
        cacheDuration: cacheDuration,
        forceRefresh: forceRefresh,
        isThirdParty: isThirdParty,
        thirdPartyBaseUrl: thirdPartyBaseUrl,
      );
      if (response is Map<String, dynamic>) {
        if (response.containsKey("success") && !response['success']) {
          return Right(Failure.fromJson(response));
        } else {
          return Left({"data": response});
        }
      } else if (response is List) {
        // If response is a List, return it as a successful result
        return Left({"data": response});
      } else {
        // Handle unexpected types
        return Right(Failure(message: "Unexpected response format"));
      }
    } catch (e) {
      return Right(Failure(message: e.toString()));
    }
  }

  @override
  FutureDynamicFailure handleCacheableRequest({
    required FutureDynamicFailure Function() apiCall,
    required String cacheKey,
    required HiveBoxes box,
    Duration ttl = const Duration(hours: 24),
    FileCacheConfig? fileConfig,
    bool shouldCache = true,
  }) async {
    final cache = getIt<HiveCacheService>();
    final fileCache = getIt<FileCacheService>();

    try {
      final response = await apiCall();

      return response.fold((l) async {
        if (l == null) throw Exception("Null response");

        final raw = Map<String, dynamic>.from(l);
        final data = raw['data'];

        /// FILE CACHING
        if (data is Map<String, dynamic>) {
          await handleFileCaching(
            data: data,
            fileConfig: fileConfig,
            fileCache: fileCache,
          );
        } else if (data is List) {
          await Future.wait(
            data.map((item) async {
              if (item is Map<String, dynamic>) {
                await handleFileCaching(
                  data: item,
                  fileConfig: fileConfig,
                  fileCache: fileCache,
                );
              }
            }),
          );
        }

        /// RESPONSE CACHING
        if (shouldCache) {
          await cache.save(
            boxType: box,
            key: cacheKey,
            value: raw,
            ttl: ttl,
          );
        }

        return Left(raw);
      }, (r) {
        final cached = cache.get(boxType: box, key: cacheKey);
        if (cached != null) return Left(cached);
        return Right(r);
      });
    } catch (_) {
      final cached = cache.get(boxType: box, key: cacheKey);
      if (cached != null) return Left(cached);

      return Right(Failure(message: "No cache available"));
    }
  }

  @override
  Future<void> handleFileCaching({
    required Map<String, dynamic> data,
    required FileCacheConfig? fileConfig,
    required FileCacheService fileCache,
  }) async {
    if (fileConfig == null) return;

    final List<Map<String, String>> errors = [];

    await Future.wait(
      fileConfig.fields.map((field) async {
        final rawValue = data[field.key];

        String? url;

        /// URL BUILDING
        if (field.urlBuilder != null) {
          url = field.urlBuilder!(rawValue);
        } else if (rawValue is String) {
          url = rawValue;
        }

        /// VALIDATION
        if (url == null || url.isEmpty) {
          data[field.localKey] = null;
          errors.add({
            'field': field.key,
            'error': 'Invalid URL',
          });
          return;
        }

        try {
          final path = await fileCache.cacheFile(url);

          /// ONLY store local path
          data[field.localKey] = path;
        } catch (e) {
          data[field.localKey] = null;
          errors.add({
            'field': field.key,
            'error': e.toString(),
          });
        }
      }),
    );

    if (errors.isNotEmpty) {
      data['_fileCacheErrors'] = errors;
    }
  }
}
