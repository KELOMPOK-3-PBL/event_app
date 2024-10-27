part of '../model.dart';

class AuthModel extends Equatable {
  final String status;
  final String message;
  final String userId;
  final String userName;
  final List<Role> roles;

  // Constructor
  const AuthModel({
    required this.status,
    required this.message,
    required this.userId,
    required this.userName,
    required this.roles,
  });

  // Convert a JSON map to the AuthModel object
  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        status: json['status'],
        message: json['message'],
        userId: json['userId'],
        userName: json['about'],
        roles: List.from(json['roles'].map((role) => Role.fromModel(role))),
      );

  // Convert the AuthModel object to a JSON map
  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  // password: json['password'],
  //   };
  // }

  @override
  List<Object?> get props => [status, message, roles, roles, userId];
}
