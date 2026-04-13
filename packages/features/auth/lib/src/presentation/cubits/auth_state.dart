import 'package:core_logic/core_logic.dart';

sealed class AuthUpdated extends BaseState {
  const AuthUpdated();
}

class AuthInitial extends AuthUpdated {
  const AuthInitial();
}

class AuthLoading extends AuthUpdated {
  const AuthLoading();
}

class AuthError extends AuthUpdated {
  final String message;
  const AuthError(this.message);
  @override
  List<Object?> get props => [message];
}

class AuthAuthenticated extends AuthUpdated {
  // final AuthEntity user;
  const AuthAuthenticated();
  @override
  List<Object?> get props => [];
}

class AuthUnauthenticated extends AuthUpdated {
  const AuthUnauthenticated();
  @override
  List<Object?> get props => [];
}

