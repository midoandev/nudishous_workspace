import '../../core_logic.dart';

// UseCase dengan parameter
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// UseCase tanpa parameter
abstract class UseCaseNoParams<Type> {
  Future<Either<Failure, Type>> call();
}

// Params kosong jika tidak ada parameter
class NoParams extends Equatable {
  const NoParams();
  @override
  List<Object?> get props => [];
}