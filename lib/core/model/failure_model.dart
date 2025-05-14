/// Class [Failure] : Return failure message, if there is any error in api call or during the time of parsing
class Failure {
  int? statusCode;
  String? message;
  dynamic data;
  bool? status;
  String? timestamp;

  Failure({
    this.statusCode = 100,
    this.message = "",
    this.data,
    this.status,
    this.timestamp,
  });

  Failure copyWith({
    int? statusCode,
    String? message,
    dynamic errorData,
    bool? status,
    String? timestamp,
  }) {
    return Failure(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      data: errorData ?? data,
      status: status ?? this.status,
      timestamp: timestamp ??  this.timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status_code': statusCode,
      'message': message,
      'data': data,
      'status': status,
      'timestamp': timestamp
    };
  }

  Failure.fromJson(Map<String, dynamic> map) {
    statusCode = map['status_code'];
    message = map['message'];
    data = map['data'];
    status = map['status'];
    timestamp = map['timestamp'];
  }
}
