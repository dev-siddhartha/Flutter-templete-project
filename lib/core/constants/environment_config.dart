import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConfig {
  EnvironmentConfig._();

  static final String appEnvironment =
      dotenv.get('APP_ENV', fallback: "Failed to load file");
  static final String baseUrl =
      dotenv.get('BASE_URL', fallback: "Failed to load file");
}
