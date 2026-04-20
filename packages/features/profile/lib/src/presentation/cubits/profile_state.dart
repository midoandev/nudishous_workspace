import 'package:core_logic/core_logic.dart';

sealed class ProfileUpdated extends BaseState {
  const ProfileUpdated();
}

class ProfileInitial extends ProfileUpdated {
  const ProfileInitial();

  @override
  List<Object?> get props => [];
}

class ProfileGuest extends ProfileUpdated {
  const ProfileGuest();

  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileUpdated {
  const ProfileLoading();

  @override
  List<Object?> get props => [];
}

class ProfileLoaded extends ProfileUpdated {
  final UserEntity user;

  const ProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class ProfileError extends ProfileUpdated {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
