import 'package:flutter/foundation.dart';
import 'package:flutter_template/core/model/failure_model.dart';
import 'normal_state.dart';

@immutable
sealed class PaginationState<T> extends NormalState<List<T>> {
  final int currentPage;
  final int lastPage;
  final int totalRecord;

  const PaginationState({
    super.data,
    super.failure,
    required this.currentPage,
    required this.lastPage,
    required this.totalRecord,
  });

  @override
  List<Object?> get props => super.props + [currentPage, lastPage, totalRecord];
}

class PaginationInitialState<T> extends PaginationState<T> {
  const PaginationInitialState()
      : super(data: const [], currentPage: 1, lastPage: 1, totalRecord: 0);
}

class PaginationLoadingState<T> extends PaginationState<T> {
  const PaginationLoadingState({super.data, super.currentPage = 1})
      : super(
          lastPage: 1,
          totalRecord: 0,
        );
}

class PaginationSuccessState<T> extends PaginationState<T> {
  const PaginationSuccessState({
    required List<T> data,
    super.currentPage = 1,
    super.lastPage = 1,
    super.totalRecord = 0,
  }) : super(
          data: data,
        );
}

class PaginationFailureState<T> extends PaginationState<T> {
  const PaginationFailureState({
    required Failure failure,
    super.data,
    super.currentPage = 1,
    super.lastPage = 1,
    super.totalRecord = 0,
  }) : super(
          failure: failure,
        );
}
