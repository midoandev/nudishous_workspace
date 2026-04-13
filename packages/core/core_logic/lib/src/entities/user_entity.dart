import 'package:core_logic/core_logic.dart';

class UserEntity extends Equatable{
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? image;

  UserEntity({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.image,
  });

  @override
  List<Object?> get props => [id, firstName, lastName, image, gender];
}
