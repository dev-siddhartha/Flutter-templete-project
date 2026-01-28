import 'package:fpdart/fpdart.dart';
import 'package:flutter_template/core/extensions/base_api_extension.dart';
import 'package:flutter_template/core/model/failure_model.dart';
import 'package:flutter_template/core/model/pagination_model.dart';
import 'package:flutter_template/core/services/state/normal_state.dart';
import 'package:flutter_template/core/services/state/pagination_state.dart';

class ApiService {
  static Future<PaginationState<T>> fetchPaginatedData<T>({
    required Future<Either<dynamic, Failure>> Function() apiCall,
    required T Function(Map<String, dynamic>) fromJson,
    required PaginationState<T> currentState,
  }) async {
    final response = await apiCall();

    return response.fold(
      (l) {
        try {
          final PaginationModel<T>? paginationModel = successDataOnMap(
            data: l,
            fromJson: (json) => PaginationModel<T>.fromJson(json, fromJson),
          );

          final List<T> newData = paginationModel?.data ?? [];
          final List<T> combinedData =
              (currentState is PaginationSuccessState<T>)
                  ? [...?currentState.data, ...newData]
                  : newData;

          return PaginationSuccessState(
            data: combinedData,
            currentPage: (paginationModel?.page?.pageNumber ?? 1) + 1,
            lastPage: (paginationModel?.page?.totalPage ?? 1),
            totalRecord: (paginationModel?.page?.totalElement ?? 0),
          );
        } catch (e) {
          // rethrow;
          return PaginationFailureState(
              failure: Failure(message: "Something went wrong"));
        }
      },
      (r) {
        return PaginationFailureState(failure: r);
      },
    );
  }

  // used for map data
  static Future<NormalState<T>> fetchNormalData<T>({
    required Future<Either<dynamic, Failure>> Function() apiCall,
    required T Function(Map<String, dynamic>) fromJson,

    /// only use when extra actions are needed to be executed after success
    Function(T data)? onSuccess,

    /// only use when extra actions are needed to be executed after failure
    Function(Failure failure)? onFailure,
  }) async {
    final response = await apiCall();

    return response.fold(
      (l) {
        try {
          final T? newData = successDataOnMap(
            data: l,
            fromJson: fromJson,
          );

          if (newData is List) {
            final List<T> combinedData = [...newData];
            onSuccess?.call(combinedData as T);
            return NormalSuccessState(data: combinedData as T);
          }
          onSuccess?.call(newData as T);
          return NormalSuccessState(data: newData as T);
        } catch (e) {
          final failure = Failure(message: "Something went wrong");
          onFailure?.call(failure);
          return NormalFailureState(failure: failure);
        }
      },
      (r) {
        onFailure?.call(r);
        return NormalFailureState(failure: r);
      },
    );
  }

  // used for listed data
  static Future<NormalState<List<T>>> fetchNormalListData<T>({
    required Future<Either<dynamic, Failure>> Function() apiCall,
    required T Function(Map<String, dynamic>) fromJson,

    /// only use when extra actions are needed to be executed after success
    Function(List<T> data)? onSuccess,

    /// only use when extra actions are needed to be executed after failure
    Function(Failure failure)? onFailure,
  }) async {
    final response = await apiCall();

    return response.fold((l) {
      try {
        final parsedList = successDataOnList(data: l, fromJson: fromJson);
        onSuccess?.call(parsedList ?? []);
        return NormalSuccessState(data: parsedList ?? []);
      } catch (e) {
        final failure = Failure(message: "Something went wrong");
        onFailure?.call(failure);
        return NormalFailureState(
          failure: failure,
        );
      }
    }, (r) {
      onFailure?.call(r);
      return NormalFailureState(failure: r);
    });
  }
}
