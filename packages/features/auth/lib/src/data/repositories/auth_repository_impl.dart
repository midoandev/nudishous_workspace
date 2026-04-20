import 'package:core_logic/core_logic.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:local_storage/local_storage.dart';
import 'package:remote_api/remote_api.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remoteDataSource;
  final PreferenceService _preferenceService;

  const AuthRepositoryImpl(this._remoteDataSource, this._preferenceService);

  @override
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      final model = await _remoteDataSource.login(
        email: email,
        password: password,
      );
      await _preferenceService.saveToken(model.accessToken ?? '');
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    }
  }

  @override
  Future<void> logout() => _preferenceService.clearToken();
}
