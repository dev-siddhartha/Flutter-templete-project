import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_template/injectable/injectable.dart';
import 'package:flutter_template/main_screen.dart';
import 'package:flutter_template/core/constants/environment_config.dart';

enum EnvType { dev, prod }

class EntryPoint {
  String getEnvFile(EnvType envType) {
    switch (envType) {
      case EnvType.prod:
        return ".env.prod";

      case EnvType.dev:
        return ".env.dev";
    }
  }

  Future<void> initializeApp({required EnvType envType}) async {
    WidgetsFlutterBinding.ensureInitialized();

    // load env files
    await dotenv.load(fileName: getEnvFile(envType));

    // init getit (di)
    await configureDependencies();

    String appName = EnvironmentConfig.appEnvironment;

    runApp(
      MyApp(
        environment: appName,
      ),
    );
  }
}
