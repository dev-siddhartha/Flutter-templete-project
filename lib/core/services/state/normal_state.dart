import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/core/model/failure_model.dart';

@immutable
abstract class NormalState<T> extends Equatable {
  final T? data;
  final Failure? failure;

  const NormalState({this.data, this.failure});

  @override
  List<Object?> get props => [data, failure];
}

class NormalInitialState<T> extends NormalState<T> {
  const NormalInitialState();
}

class NormalLoadingState<T> extends NormalState<T> {
  const NormalLoadingState({super.data});
}

class NormalSuccessState<T> extends NormalState<T> {
  const NormalSuccessState({super.data});
}

class NormalFailureState<T> extends NormalState<T> {
  const NormalFailureState({super.failure, super.data});
}
