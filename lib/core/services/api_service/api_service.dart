import 'package:fpdart/fpdart.dart';
import 'package:flutter_template/core/extensions/base_api_extension.dart';
import 'package:flutter_template/core/model/failure_model.dart';
import 'package:flutter_template/core/model/pagination_model.dart';
import 'package:flutter_template/core/services/state/normal_state.dart';
import 'package:flutter_template/core/services/state/pagination_state.dart';

class ApiService {
  /// Fetches paginated data from an API and merges it with existing state.
  ///
  /// Expected behavior:
  /// - Executes [apiCall] which returns `Either`:
  ///   - Left: successful response payload (Map-like structure)
  ///   - Right: [Failure]
  /// - Parses pagination data using `successDataOnMap`
  /// - Merges new items with existing state if it is [PaginationSuccessState]
  ///
  /// Pagination rules:
  /// - `pageNumber` is incremented by 1 after success
  /// - If no previous state exists, starts fresh list
  ///
  /// Failure cases:
  /// - Parsing errors return [PaginationFailureState]
  /// - API failure returns [PaginationFailureState] directly
  ///
  /// WARNING:
  /// - This silently swallows parsing errors and replaces them with generic failure
  /// - This makes debugging production issues significantly harder
  ///
  /// Type [T] represents the model type parsed from JSON.
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

  /// Used for map,
  /// Fetches a single object from an API and wraps it in [NormalState].
  ///
  /// Expected response:
  /// - Nested JSON structure compatible with `successDataOnMap`
  ///
  /// Behavior:
  /// - Calls [apiCall]
  /// - Parses response into type [T]
  /// - Invokes optional [onSuccess] or [onFailure] callbacks
  ///
  /// Edge cases:
  /// - If parsed data is a List at runtime, it is incorrectly cast to List
  ///   (this indicates a type design flaw in the API or parser)
  ///
  /// Failure handling:
  /// - Any parsing exception returns [NormalFailureState]
  /// - API failure returns [NormalFailureState]
  ///
  /// WARNING:
  /// - Contains unsafe casts: `(newData as T)`
  /// - Can crash at runtime if backend shape changes
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
          // final failure = Failure(message: "Something went wrong");
          final failure = Failure(message: e.toString());
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

  /// Used for list of map,
  /// Fetches a list of objects from an API and returns [NormalState<List<T>>].
  ///
  /// Expected response:
  /// - JSON structure compatible with `successDataOnList`
  ///
  /// Behavior:
  /// - Calls [apiCall]
  /// - Parses list of maps into `List<T>`
  /// - Returns empty list if parsing returns null
  /// - Calls optional callbacks on success/failure
  ///
  /// Failure cases:
  /// - Parsing exceptions return [NormalFailureState]
  /// - API failure returns [NormalFailureState]
  ///
  /// Safety notes:
  /// - Uses null-coalescing fallback (`?? []`) which hides API contract issues
  /// - Errors are not propagated, only converted into generic failure state
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
