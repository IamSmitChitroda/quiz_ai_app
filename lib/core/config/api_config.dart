import 'environment_config.dart';

class ApiConfig {
  static String get groqApiKey => EnvironmentConfig.groqApiKey;
  static const String groqBaseUrl =
      'https://api.groq.com/openai/v1/chat/completions';
  static const String defaultModel = 'openai/gpt-oss-20b';

  static Map<String, String> get headers => {
        'Authorization': 'Bearer $groqApiKey',
        'Content-Type': 'application/json',
      };
}
