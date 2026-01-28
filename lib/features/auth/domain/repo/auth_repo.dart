import 'package:flutter_template/core/type_defs.dart';

abstract class AuthRepo {
  FutureDynamicFailure loginUser(
      {required String username, required String password});

  FutureDynamicFailure getProfile();
}
