import 'package:auth/src/data/models/user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:remote_api/remote_api.dart';

@LazySingleton()
class AuthRemoteDatasource {
  final Dio _dio;

  const AuthRemoteDatasource(this._dio);

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }
}
