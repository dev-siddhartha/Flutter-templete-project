import 'package:fpdart/fpdart.dart';
import 'package:flutter_template/core/model/failure_model.dart';

/// repo typedef
typedef FutureDynamicFailure = Future<Either<dynamic, Failure>>;
typedef DynamicFailure = Either<dynamic, Failure>;
