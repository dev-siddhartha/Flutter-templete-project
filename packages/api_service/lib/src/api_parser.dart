import 'package:dio/dio.dart';

class ApiParser {
  static dynamic parseResponse(Response response) {
    if (response.data is List) {
      return List<Map<String, dynamic>>.from(response.data);
    } else if (response.data is Map) {
      return Map<String, dynamic>.from(response.data);
    }
    return response.data;
  }
}
