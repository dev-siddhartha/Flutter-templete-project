import 'package:api_request_handler/api_service.dart';
import 'package:flutter_template/core/storage/cache/file/file_cache_config.dart';
import 'package:flutter_template/core/storage/cache/file/file_cache_service.dart';
import 'package:flutter_template/core/storage/hive_keys.dart';
import 'package:flutter_template/core/type_defs.dart';
export 'package:dio/dio.dart';
export 'package:api_request_handler/api_service.dart';

abstract class NetworkService {
  /// Initializes the global networking service used for all API calls.
  ///
  /// Responsibilities:
  /// - Retrieves device information (fingerprint, identifiers)
  /// - Builds global HTTP headers used across all requests
  /// - Configures the API client with:
  ///   - Base URL from environment config
  ///   - Global headers
  ///   - Request interceptors (e.g., authentication token handling)
  ///
  /// Headers injected globally:
  /// - X-Device-Token: Unique device fingerprint
  /// - X-Client-Type: Application client type identifier
  /// - client_id: Backend client identifier
  /// - Accept: Expected response format
  ///
  /// WARNING:
  /// - Must be called before any API request is executed
  /// - Device info retrieval is asynchronous and required for header construction
  /// - Missing initialization will cause undefined request behavior
  Future<void> initilizeNetworkService();

  /// Executes an HTTP request to the backend API and returns a wrapped result.
  ///
  /// Supports:
  /// - GET / POST / PUT / DELETE via [RequestMethod]
  /// - Query parameters via [params]
  /// - Request body via [data] (Map or FormData)
  /// - Custom headers per request
  /// - Optional caching via [cacheDuration]
  /// - Forced refresh control via [forceRefresh]
  /// - Third-party API routing via [isThirdParty] and [thirdPartyBaseUrl]
  ///
  /// Response handling:
  /// - If response is Map:
  ///   - If "success" == false → returns Failure (Right)
  ///   - Otherwise wraps response in {"data": response}
  /// - If response is List:
  ///   - Wraps in {"data": response}
  /// - Any other type:
  ///   - Returns Failure with unexpected format message
  ///
  /// Error handling:
  /// - Network or runtime exceptions are caught and converted into Failure
  ///
  /// Type safety:
  /// - [data] must be either:
  ///   - Map&lt;String, dynamic&gt;
  ///   - FormData
  ///
  /// WARNING:
  /// - Response typing is dynamic and normalized manually
  /// - API contract violations are not strictly enforced
  /// - Unexpected backend changes may silently break parsing logic
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

  /// Generic cache handler for API requests with optional file caching.
  ///
  /// Handles the following scenarios:
  /// - ✔ API response with single file (e.g. profile image)
  /// - ✔ API response with multiple files (e.g. document front/back)
  /// - ✔ API response with list of items (each item can contain files)
  /// - ✔ API response without files
  /// - ✔ File-only scenarios (no meaningful response body)
  /// - ✔ Supports both full URLs and partial file keys via [FileField.urlBuilder]
  ///
  /// Behavior:
  /// - On success:
  ///   - Processes file caching (if [fileConfig] provided)
  ///   - Stores response in Hive (if [shouldCache] = true)
  /// - On API failure:
  ///   - Attempts to return cached data (if available)
  /// - On exception:
  ///   - Falls back to cache, else returns failure
  ///
  /// File caching:
  /// - Downloads files using [FileCacheService]
  /// - Stores local file paths in response under [FileField.localKey]
  /// - Does NOT fail entire request if file caching fails
  /// - Collects file-related errors in `_fileCacheErrors`
  ///
  /// Notes:
  /// - Mutates response map by injecting local file paths
  /// - Assumes response format: { "data": ... }
  /// - Supports both Map and List inside `data`
  ///
  /// Limitations:
  /// - ❗ Does NOT support nested keys (e.g. "user.image")
  /// - ❗ No deduplication guarantees for repeated URLs
  /// - ❗ Large file downloads are blocking
  ///
  /// Parameters:
  /// - [apiCall]: function that executes the API request, Use apiRequest fn
  /// - [cacheKey]: unique key for caching
  /// - [box]: Hive box to store data
  /// - [ttl]: cache validity duration
  /// - [fileConfig]: configuration for file caching
  /// - [shouldCache]: toggle to enable/disable caching
  ///
  /// for custom file url implementation
  /// urlBuilder: (value) {
  ///    if (value is! String) return null;
  ///    return "${EnvironmentConfig.baseUrl}$value";
  ///  },
  FutureDynamicFailure handleCacheableRequest({
    required FutureDynamicFailure Function() apiCall,
    required String cacheKey,
    required HiveBoxes box,
    Duration ttl = const Duration(hours: 24),
    FileCacheConfig? fileConfig,
  });

  /// Helper fn to process file caching.
  /// Processes file caching for a single response object.
  ///
  /// Iterates over [FileCacheConfig.fields] and:
  /// - Extracts raw value from [data] using [FileField.key]
  /// - Builds final URL using [FileField.urlBuilder] (if provided)
  /// - Falls back to raw string if already a full URL
  /// - Downloads file and stores local path in [FileField.localKey]
  ///
  /// Error Handling:
  /// - Invalid or empty URLs are skipped
  /// - File download failures do NOT throw
  /// - Errors are collected in `_fileCacheErrors`
  ///
  /// Notes:
  /// - Runs in parallel using Future.wait
  /// - Mutates the input [data] map
  /// - Safe for partial failures (graceful degradation)
  ///
  /// Limitations:
  /// - ❗ No retry mechanism
  /// - ❗ No URL validation beyond null/empty
  Future<void> handleFileCaching({
    required Map<String, dynamic> data,
    required FileCacheConfig? fileConfig,
    required FileCacheService fileCache,
  });
}
