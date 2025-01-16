enum ParseType {
  int,
  double,
  bool,
  string,
  num,
}

class ParseService {
  static dynamic parseData(dynamic data, {required ParseType type}) {
    if (data == null) return null;

    switch (type) {
      case ParseType.int:
        return _toInt(data);
      case ParseType.num:
        return _toNum(data);
      case ParseType.double:
        return _toDouble(data);
      case ParseType.bool:
        return _toBool(data);
      case ParseType.string:
        return data.toString();
    }
  }

  static num? _toNum(dynamic data) {
    if (data == null) return null;

    if (data is num) return data;
    if (data is String) {
      final parsedDouble = double.tryParse(data);
      if (parsedDouble != null) {
        return parsedDouble % 1 == 0 ? parsedDouble.toInt() : parsedDouble;
      }
      return int.tryParse(data);
    }
    if (data is bool) return data ? 1 : 0;

    return null;
  }

  static int? _toInt(dynamic data) {
    if (data == null) return null;

    if (data is int) return data;
    if (data is double) return data.toInt();
    if (data is String) return int.tryParse(data);
    if (data is bool) return data ? 1 : 0;

    return null;
  }

  static double? _toDouble(dynamic data) {
    if (data == null) return null;

    if (data is double) return data;
    if (data is num) return data.toDouble();
    if (data is String) return double.tryParse(data);
    if (data is bool) return data ? 1.0 : 0.0;

    return null;
  }

  static bool? _toBool(dynamic data) {
    if (data == null) return null;

    if (data is bool) return data;
    if (data is String) {
      switch (data.toLowerCase()) {
        case 'true':
          return true;
        case 'false':
          return false;
        default:
          return null;
      }
    }
    if (data is num) {
      return data == 1 || data == 1.0
          ? true
          : data == 0 || data == 0.0
              ? false
              : null;
    }

    return null;
  }
}
