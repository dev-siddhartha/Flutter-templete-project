import 'dart:developer';

/// Extracts and parses a single object of type [T] from a nested API response.
///
/// This function expects a response structure like:
/// ```json
/// {
///   "data": {
///     "data": { ... }
///   }
/// }
/// ```
///
/// It also supports a fallback format:
/// ```json
/// {
///   "data": { ... }
/// }
/// ```
///
/// Behavior:
/// - Returns `null` if:
///   - `data['data']` is missing or not a map
///   - Nested `data` key is missing or empty
/// - If the inner `data` key does not exist, attempts to parse the outer map
///
/// [data]: Raw API response
/// [fromJson]: Function to convert JSON into type [T]
///
/// Returns a parsed object of type [T] or `null` if parsing fails.
T? successDataOnMap<T>({
  required Map<String, dynamic> data,
  required T Function(Map<String, dynamic> data) fromJson,
}) {
  final l = data['data'];

  /// if no response at all
  if (l == null || l is! Map) {
    return null;
  }

  /// if l is not null but also doesn have data key
  if (!l.containsKey('data')) {
    return fromJson(l as Map<String, dynamic>);
  }

  final formatedData = l['data'];

  /// if data key is empty
  if (formatedData == null ||
      formatedData is! Map<String, dynamic> ||
      formatedData.isEmpty) {
    return null;
  }

  return fromJson(formatedData);
}

/// Extracts and parses a list of objects of type [T] from a nested API response.
///
/// Expected response structure:
/// ```json
/// {
///   "data": {
///     "data": [ {...}, {...} ]
///   }
/// }
/// ```
///
/// Behavior:
/// - Returns `null` if:
///   - `data['data']` is missing or not a map
///   - Nested `data` is not a list or is empty
/// - Filters out invalid items that are not `Map<String, dynamic>`
/// - Attempts to parse each item using [fromJson]
/// - Returns `null` if parsing throws an error
///
/// [data]: Raw API response
/// [fromJson]: Function to convert each JSON object into type [T]
///
/// Returns a list of parsed objects or `null` if extraction/parsing fails.
List<T>? successDataOnList<T>({
  required Map<String, dynamic> data,
  required T Function(Map<String, dynamic> data) fromJson,
}) {
  final l = data['data'];

  /// if no response at all
  if (l == null || l is! Map) return null;
  final formatedData = l['data'];

  /// if data key is empty
  if (formatedData == null || formatedData is! List || formatedData.isEmpty) {
    return null;
  }

  try {
    return formatedData
        .whereType<Map<String, dynamic>>()
        .map(fromJson)
        .toList();
  } catch (e) {
    log(e.toString());
    return null;
  }
}
