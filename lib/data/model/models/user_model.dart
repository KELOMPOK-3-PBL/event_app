part of '../model.dart';

class UsersModel extends Equatable {
  final String status;
  final String message;
  final List<UserDataModel>? listUserData;
  final UserDataModel? userData;

  // Constructor
  const UsersModel({
    required this.status,
    required this.message,
    this.listUserData,
    this.userData,
  });

  // Convert a JSON map to the ListUsersModel object
  factory UsersModel.fromJsonforList({required Map<String, dynamic> json}) =>
      UsersModel(
        status: json['status'],
        message: json['message'],
        listUserData: (json['data'] as List<dynamic>?)
            ?.map(
                (item) => UserDataModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );

  factory UsersModel.fromJsonForSingle({required Map<String, dynamic> json}) =>
      UsersModel(
        status: json['status'],
        message: json['message'],
        userData: UserDataModel.fromJson(json['data'] as Map<String, dynamic>),
      );
  @override
  List<Object?> get props => [status, message, listUserData];
}

class UserDataModel extends Equatable {
  final String userid;
  final String username;
  final String email;
  final List<String> roles;
  final String? about;
  final String? avatar;

  // Constructor
  const UserDataModel({
    required this.userid,
    required this.username,
    required this.email,
    required this.roles,
    this.about,
    this.avatar,
  });

  // Convert a JSON map to the UserModel object
  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
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
