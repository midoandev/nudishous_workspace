// packages/data/remote_api/lib/src/config/dio_config.dart

class DioConfig {
  // Diambil dari --dart-define saat build (flavor)
  static const baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://dev-api.nudishous.com', // fallback dev
  );

  static const connectTimeout = Duration(seconds: 30);
  static const receiveTimeout = Duration(seconds: 30);
  static const sendTimeout = Duration(seconds: 30);
}