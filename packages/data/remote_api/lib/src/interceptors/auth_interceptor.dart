import 'package:dio/dio.dart';
import 'package:local_storage/local_storage.dart';

class AuthInterceptor extends Interceptor {
  final PreferenceService _secureStorageService;

  AuthInterceptor(this._secureStorageService);

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final token = await _secureStorageService.getToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    if (err.response?.statusCode == 401) {
      // Token expired — clear token
      await _secureStorageService.clearToken();
      // Bisa trigger logout via getIt jika perlu
    }
    handler.next(err);
  }
}