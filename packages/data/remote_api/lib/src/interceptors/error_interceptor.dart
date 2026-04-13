import 'package:core_logic/core_logic.dart';
import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Konversi DioException → Exception yang lebih meaningful
    final exception = switch (err.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout =>
      const NetworkException(),

      DioExceptionType.badResponse => switch (err.response?.statusCode) {
        401 => const UnauthorizedException(),
        404 => ServerException(
          err.response?.data?['message'] ?? 'Data tidak ditemukan',
          statusCode: 404,
        ),
        500 => ServerException(
          err.response?.data?['message'] ?? 'Server error',
          statusCode: 500,
        ),
        _ => ServerException(
          err.response?.data?['message'] ?? 'Terjadi kesalahan',
          statusCode: err.response?.statusCode,
        ),
      },

      DioExceptionType.connectionError =>
      const NetworkException(),

      _ => const NetworkException(),
    };

    // Wrap ke DioException dengan error kita
    handler.next(
      err.copyWith(error: exception),
    );
  }
}