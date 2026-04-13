import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure(this.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

// Network / API errors
class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure() : super('Sesi habis, silakan login kembali');
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

// Local errors
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

// Validation errors
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

// Unknown
class UnknownFailure extends Failure {
  const UnknownFailure() : super('Terjadi kesalahan, coba lagi');
}