import 'package:api_service/api_service.dart';
import 'package:flutter_template/core/type_defs.dart';
export 'package:api_service/api_service.dart';
export 'package:dio/dio.dart';

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
}
