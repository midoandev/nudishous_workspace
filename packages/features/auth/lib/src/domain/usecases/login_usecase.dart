import 'package:core_logic/core_logic.dart';

import '../repositories/auth_repository.dart';

@lazySingleton
class LoginUseCase {
  final AuthRepository _repository;
  const LoginUseCase(this._repository);

  Future<Either<Failure, void>> call({
    required String email,
    required String password,
  }) => _repository.login(email: email, password: password);
}