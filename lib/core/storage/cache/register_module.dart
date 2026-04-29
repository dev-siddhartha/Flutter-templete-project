import 'package:injectable/injectable.dart';

import 'app_database.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<AppDatabase> db() async {
    return await AppDatabase.create();
  }
}