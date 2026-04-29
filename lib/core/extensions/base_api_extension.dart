import 'dart:developer';

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

// T extractData<T>({
//   required Map<String, dynamic> raw,
//   required T Function(Map<String, dynamic>) fromJson,
// }) {
//   final inner = raw['data'];

//   if (inner == null || inner is! Map<String, dynamic>) {
//     throw Exception("Invalid API structure");
//   }

//   return fromJson(inner);
// }
