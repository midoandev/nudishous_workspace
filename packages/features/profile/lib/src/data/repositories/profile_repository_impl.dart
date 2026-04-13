import 'package:core_logic/core_logic.dart';
import 'package:local_storage/local_storage.dart';
import 'package:remote_api/remote_api.dart';

import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource _remoteDataSource;
  final PreferenceService _preferenceService;

  const ProfileRepositoryImpl(this._remoteDataSource, this._preferenceService);

  @override
  Future<Either<Failure, UserEntity>> getProfile() async {
    try {
      final model = await _remoteDataSource.getProfile();
      final data = model.toEntity();
      return Right(data);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateProfile(UserEntity user) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}
