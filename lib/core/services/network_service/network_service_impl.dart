import 'package:dartz/dartz.dart';
import 'package:flutter_template/core/constants/api_constants.dart';
import 'package:flutter_template/core/constants/environment_config.dart';
import 'package:flutter_template/core/model/device_info_model.dart';
import 'package:flutter_template/core/model/failure_model.dart';
// import 'package:flutter_template/core/services/network_service/api_interceptor.dart';
import 'package:flutter_template/core/services/network_service/device_info/device_info_service.dart';
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
        //! for this, need create custom api_interceptor  
        // TokenInterceptor(),

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
}
