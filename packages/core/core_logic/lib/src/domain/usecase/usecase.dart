import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../error/failure.dart';

// Gunakan 'T' atau 'R' untuk menghindari bentrok dengan class 'Type' bawaan Dart
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

// UseCase tanpa parameter
abstract class UseCaseNoParams<T> {
  Future<Either<Failure, T>> call();
}

// Params kosong tetap sama
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}