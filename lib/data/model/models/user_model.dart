part of '../model.dart';

class UserModel extends Equatable {
  final String username;
  final String email;
  final List<Role> roles;
  final String about;
  final String avatar;

  // Constructor
  const UserModel({
    required this.username,
    required this.email,
    required this.roles,
    required this.about,
    required this.avatar,
  });

  // Convert a JSON map to the UserModel object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      roles: List.from(json['roles'].map((role) => Role.fromModel(role))),
      about: json['about'],
      avatar: json['avatar'],
    );
  }

  // Convert the UserModel object to a JSON map
  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  // password: json['password'],
  //   };
  // }

  @override
  List<Object?> get props => [username, email, roles, about];
}
