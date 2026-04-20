import 'package:core_logic/core_logic.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  });

  Future<void> logout();
}
