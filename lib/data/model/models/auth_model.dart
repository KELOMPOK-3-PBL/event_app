part of '../model.dart';

class AuthModel extends Equatable {
  // final String? statusCode;
  final String status;
  final String message;
  final String? data;
  // final String? userId;
  // final String? userName;
  // final List<Role>? roles;

  // Constructor
  const AuthModel({
    // required this.statusCode,
    required this.status,
    required this.message,
    this.data,
    // this.userId,
    // this.userName,
    // this.roles,
  });

  // Convert a JSON map to the AuthModel object
  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        // statusCode: '',
        status: json['status'],
        message: json['message'],
        data: json['data'],
        // userId: json['userId'],
        // userName: json['about'],
        // roles: List.from(json['roles'].map((role) => Role.fromModel(role))),
      );

  // Convert the AuthModel object to a JSON map
  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  // password: json['password'],
  //   };
  // }

  @override
  List<Object?> get props => [status, message, data];
}
