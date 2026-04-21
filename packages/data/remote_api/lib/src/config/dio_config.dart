// packages/data/remote_api/lib/src/config/dio_config.dart

import 'package:core_logic/core_logic.dart';

class DioConfig {
  // Diambil dari --dart-define saat build (flavor)
  static String baseUrl = FlavorConfig.instance.apiBaseUrl ?? '';

  static const connectTimeout = Duration(seconds: 30);
  static const receiveTimeout = Duration(seconds: 30);
  static const sendTimeout = Duration(seconds: 30);
}
