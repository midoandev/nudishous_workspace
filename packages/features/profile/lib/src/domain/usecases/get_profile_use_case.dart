import 'package:core_logic/core_logic.dart';
import '../repositories/profile_repository.dart';

@lazySingleton
class GetProfileUseCase extends UseCaseNoParams<UserEntity> {
  final ProfileRepository _repository;
  GetProfileUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call() => _repository.getProfile();
}