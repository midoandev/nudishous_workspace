import 'package:core_logic/core_logic.dart';
import 'package:dio/dio.dart';
import 'package:local_storage/local_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../config/dio_config.dart';
import '../interceptors/auth_interceptor.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(PreferenceService secureStorageService) {
    final dio = Dio(
      BaseOptions(
        baseUrl: DioConfig.baseUrl,
        connectTimeout: DioConfig.connectTimeout,
        receiveTimeout: DioConfig.receiveTimeout,
        sendTimeout: DioConfig.sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(secureStorageService), // ← inject token
      PrettyDioLogger(                        // ← logging
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
        compact: true,
      ),
    ]);

    return dio;
  }
}