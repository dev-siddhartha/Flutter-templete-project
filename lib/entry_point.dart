import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_template/core/security/rasp_controller.dart';
import 'package:flutter_template/core/services/network_service/network_service.dart';
import 'package:flutter_template/core/storage/cache/hive/hive_initializer.dart';
import 'package:flutter_template/core/storage/secure_storage/secure_storage_service.dart';
import 'package:flutter_template/core/utils/app_imports.dart';
import 'package:flutter_template/features/auth/viewmodel/bloc/auth_cubit/auth_cubit.dart';
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

    await getIt<NetworkService>().initilizeNetworkService();

    await getIt<HiveInitializer>().init();

    getIt<AuthCubit>().checkLogin();

    String appName = EnvironmentConfig.appEnvironment;
    final response = await RaspController.instance.runStartupChecks();

    if (response == RaspResponse.degrade) {
      // Wipe all derived keys before showing anything
      getIt<SecureStorageService>().deleteAllSecureData();
      runApp(const _HardBlockApp());
      return;
    }

    runApp(
      MyApp(
        environment: appName,
      ),
    );
  }
}

class _HardBlockApp extends StatelessWidget {
  const _HardBlockApp();
  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: Scaffold(
          body: Center(child: TextWidget('This device is not supported.')),
        ),
      );
}
