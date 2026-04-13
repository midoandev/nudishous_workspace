import 'package:core_logic/core_logic.dart';
import 'package:remote_api/remote_api.dart';

import '../models/profile_model.dart';

@LazySingleton()
class ProfileRemoteDatasource {
  final Dio _dio;

  const ProfileRemoteDatasource(this._dio);

  Future<ProfileModel> getProfile() async {
    final response = await _dio.get('/auth/me');
    return ProfileModel.fromJson(response.data as Map<String, dynamic>);
  }

}
