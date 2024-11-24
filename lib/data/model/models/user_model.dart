part of '../model.dart';

class ListUsersModel extends Equatable {
  final String status;
  final String message;
  final List<UserModel>? data;

  // Constructor
  const ListUsersModel({
    required this.status,
    required this.message,
    this.data,
  });

  // Convert a JSON map to the ListUsersModel object
  factory ListUsersModel.fromJson({required Map<String, dynamic> json}) =>
      ListUsersModel(
        status: json['status'],
        message: json['message'],
        data: (json['data'] as List<dynamic>?)
            ?.map((item) => UserModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );

  @override
  List<Object?> get props => [status, message, data];
}

class UserModel extends Equatable {
  final String userid;
  final String username;
  final String email;
  final List<String> roles;
  final String? about;
  final String? avatar;

  // Constructor
  const UserModel({
    required this.userid,
    required this.username,
    required this.email,
    required this.roles,
    this.about,
    this.avatar,
  });

  // Convert a JSON map to the UserModel object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userid: json['user_id'].toString(),
      username: json['username'],
      email: json['email'],
      roles: (json['roles'] as String).split(',').map((e) => e.trim()).toList(),
      about: json['about'],
      avatar: json['avatar'],
    );
  }

  @override
  List<Object?> get props => [username, email, roles, about];
}

// class Role {
//   final String role;
//   Role({required this.role});
//   factory Role.fromModel(Map<String, dynamic> json) =>
//       Role(role: json['roles']);
// }
