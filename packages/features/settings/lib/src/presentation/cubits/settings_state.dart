import 'package:core_logic/core_logic.dart';

sealed class SettingsUpdated extends BaseState {
  const SettingsUpdated();
}

class ProfileInitial extends SettingsUpdated {
  const ProfileInitial();
  @override
  List<Object?> get props => [];
}

class ProfileGuest extends SettingsUpdated {
  const ProfileGuest();
  @override
  List<Object?> get props => [];
}

class ProfileLoading extends SettingsUpdated {
  const ProfileLoading();
  @override
  List<Object?> get props => [];
}

class ProfileLoaded extends SettingsUpdated {
  final UserEntity user;
  const ProfileLoaded(this.user);
  @override
  List<Object?> get props => [user];
}

class ProfileError extends SettingsUpdated {
  final String message;
  const ProfileError(this.message);
  @override
  List<Object?> get props => [message];
}