import 'package:dio/dio.dart';
import 'api_client.dart';
import 'cache_service.dart';

enum RequestMethod { get, post, put, patch, delete }

class ApiRequest {
  static final ApiRequest _instance = ApiRequest._internal();
  factory ApiRequest() => _instance;

  final CacheService _cacheService = CacheService();
  final Map<String, CancelToken> _cancelTokens = {};

  late Dio _dio;

  Dio get dio => _dio;

  ApiRequest._internal();

  /// Initializes API Client
  Future<void> initialize({
    required String baseUrl,
    Map<String, String>? globalHeaders,
    List<Interceptor>? interceptors,
  }) async {
    ApiClient().initialize(
      baseUrl: baseUrl,
      globalHeaders: globalHeaders,
      interceptors: interceptors,
    );
    _dio = ApiClient().dio;
    await _cacheService.init();
  }

  /// Returns a new Dio instance for third-party API requests
  Dio getThirdPartyDio(String baseUrl, {Map<String, String>? headers}) {
    return ApiClient().createThirdPartyDio(baseUrl, headers: headers);
  }

  /// Generates a cache key based on the endpoint & parameters
  String _generateCacheKey(String endpoint, Map<String, dynamic>? params) {
    return "$endpoint-${params.toString()}";
  }

  /// Converts `RequestMethod` enum to string
  String _parseRequestMethod(RequestMethod method) {
    switch (method) {
      case RequestMethod.get:
        return "GET";
      case RequestMethod.post:
        return "POST";
      case RequestMethod.put:
        return "PUT";
      case RequestMethod.patch:
        return "PATCH";
      case RequestMethod.delete:
        return "DELETE";
    }
  }

  /// General API request handler
  Future<dynamic> request({
    required String endpoint,
    required RequestMethod method,
    Map<String, dynamic>? params,

    /// either a [Map<String, dynamic>] or a [FormData] instance
    Object? data,
    Map<String, String>? headers,
    String? contentType,
    Duration? cacheDuration,
    bool forceRefresh = false,
    bool isThirdParty = false,
    String? thirdPartyBaseUrl,
  }) async {
    // Ensure 'data' is either a [Map<String, dynamic>] or a [FormData] instance
    assert(
      data == null || data is Map<String, dynamic> || data is FormData,
      'data must be either Map<String, dynamic> or FormData',
    );
    final String cacheKey = _generateCacheKey(endpoint, params);

    // Use cached data if available
    if (!forceRefresh) {
      var cachedData = _cacheService.getData(cacheKey);
      if (cachedData != null) return cachedData;
    }

    final CancelToken cancelToken = CancelToken();
    _cancelTokens[cacheKey] = cancelToken;

    Dio apiDio = isThirdParty && thirdPartyBaseUrl != null
        ? getThirdPartyDio(thirdPartyBaseUrl, headers: headers)
        : _dio;

    try {
      Response response = await _makeRequest(
        apiDio,
        endpoint,
        method,
        params,
        data,
        headers,
        contentType,
        cancelToken,
      );

      dynamic parsedResponse = response.data;
      // dynamic parsedResponse = ApiParser.parseResponse(response);

      // Cache successful response
      if (cacheDuration != null) {
        await _cacheService.storeData(cacheKey, parsedResponse, cacheDuration);
      }

      return parsedResponse;
    } on DioException catch (e) {
      return _handleNetworkError(e);
    } finally {
      _cancelTokens.remove(cacheKey);
    }
  }

  /// Handles API request execution
  Future<Response> _makeRequest(
    Dio apiDio,
    String endpoint,
    RequestMethod method,
    Map<String, dynamic>? params,

    /// either a [Map<String, dynamic>] or a [FormData] instance
    Object? data,
    Map<String, String>? headers,
    String? contentType,
    CancelToken cancelToken,
  ) async {
    // Ensure 'data' is either a Map<String, dynamic> or a FormData instance
    assert(
      data == null || data is Map<String, dynamic> || data is FormData,
      'data must be either Map<String, dynamic> or FormData',
    );

    Options options = Options(
      method: _parseRequestMethod(method),
      headers: headers,
      contentType: contentType,
    );

    switch (method) {
      case RequestMethod.get:
        return await apiDio.get(endpoint,
            queryParameters: params,
            options: options,
            cancelToken: cancelToken);
      case RequestMethod.post:
        return await apiDio.post(endpoint,
            data: data,
            queryParameters: params,
            options: options,
            cancelToken: cancelToken);
      case RequestMethod.put:
        return await apiDio.put(endpoint,
            data: data,
            queryParameters: params,
            options: options,
            cancelToken: cancelToken);
      case RequestMethod.patch:
        return await apiDio.patch(endpoint,
            data: data,
            queryParameters: params,
            options: options,
            cancelToken: cancelToken);
      case RequestMethod.delete:
        return await apiDio.delete(endpoint,
            data: data,
            queryParameters: params,
            options: options,
            cancelToken: cancelToken);
    }
  }

  /// Handles network-related errors (timeouts, no internet, etc.)
  Map<String, dynamic> _handleNetworkError(DioException e) {
    String message = 'An error occurred';

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Server took too long to respond';
        break;
      case DioExceptionType.connectionError:
        message = 'Network unavailable or unexpected error';
        break;
      case DioExceptionType.cancel:
        message = 'Request Cancelled';
        break;
      case DioExceptionType.badCertificate:
        message = 'Bad Certificate';
        break;
      default:
        try {
          message = e.response?.data?['message'] ??
              e.response?.statusMessage ??
              'An error occurred';
        } catch (e) {
          message = 'An error occurred';
        }
    }

    return {
      'status_code': e.response?.statusCode ?? 100,
      'message': message,
      'data': e.response?.data ?? {},
      'success': false,
    };
  }

  /// Clears cached API responses for a specific endpoint
  void clearCache(String endpoint, {Map<String, dynamic>? params}) {
    _cacheService.clearCache(_generateCacheKey(endpoint, params));
  }
}
