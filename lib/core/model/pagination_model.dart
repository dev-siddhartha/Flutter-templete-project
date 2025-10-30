class PaginationModel<T> {
  Page? page;
  List<T>? data;

  PaginationModel({this.page, this.data});

  factory PaginationModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginationModel<T>(
      page: json['page'] != null ? Page.fromJson(json['page']) : null,
      data: json['data'] != null
          ? List<T>.from((json['data'] as List).map((e) => fromJsonT(e)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page?.toJson(),
      'data': data?.map((e) {
        if (e is JsonSerializable) return e.toJson();
        throw Exception('Model does not implement toJson');
      }).toList(),
    };
  }
}

class Page {
  int? totalPage;
  int? totalElement;
  bool? last;
  bool? first;
  int? pageNumber;
  int? pageSize;

  Page(
      {this.totalPage,
      this.totalElement,
      this.last,
      this.first,
      this.pageNumber,
      this.pageSize});

  Page.fromJson(Map<String, dynamic> json) {
    totalPage = json['totalPage'];
    totalElement = json['totalElement'];
    last = json['last'];
    first = json['first'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalPage'] = totalPage;
    data['totalElement'] = totalElement;
    data['last'] = last;
    data['first'] = first;
    data['pageNumber'] = pageNumber;
    data['pageSize'] = pageSize;
    return data;
  }
}

abstract class JsonSerializable {
  Map<String, dynamic> toJson();
}
