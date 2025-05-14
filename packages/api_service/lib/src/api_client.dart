import 'package:dio/dio.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late Dio _dio;
  late String _baseUrl;
  Map<String, String> _globalHeaders = {}; // Store global headers

  ApiClient._internal();

  /// Initialize API Client with Base URL
  void initialize({
    required String baseUrl,
    Map<String, String>? globalHeaders,
    List<Interceptor>? interceptors,
  }) {
    _baseUrl = baseUrl;
    _globalHeaders = globalHeaders ?? {}; // Set default headers if provided

    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: _globalHeaders, // Apply global headers
    ));

    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  /// Function to update global headers dynamically
  void updateGlobalHeaders(Map<String, String> newHeaders) {
    // Merge new headers with existing global headers
    _globalHeaders.addAll(newHeaders);
    _dio.options.headers = _globalHeaders; // Apply merged headers
  }

  Dio get dio => _dio;

  /// Returns a new Dio instance for third-party APIs
  Dio createThirdPartyDio(String baseUrl, {Map<String, String>? headers}) {
    return Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));
  }
}
