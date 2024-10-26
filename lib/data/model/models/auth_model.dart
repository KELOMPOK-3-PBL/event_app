part of '../model.dart';

class AuthModel extends Equatable {
  final String username;
  final String email;
  final String password;
  final String role;
  final String about;

  // Constructor
  const AuthModel({
    required this.username,
    required this.email,
    required this.password,
    required this.role,
    required this.about,
  });

  // Convert a JSON map to the AuthModel object
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      about: json['about'],
    );
  }

  // Convert the AuthModel object to a JSON map
  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  // password: json['password'],
  //   };
  // }

  @override
  List<Object?> get props => [username, email, password, role, about];
}

class Role {
  final String role;
  Role({required this.role});
  factory Role.fromModel(Map<String, dynamic> json) =>
      Role(role: json['roles']);
}
