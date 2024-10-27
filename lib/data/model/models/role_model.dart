part of '../model.dart';

class Role {
  final String role;
  Role({required this.role});
  factory Role.fromModel(Map<String, dynamic> json) =>
      Role(role: json['roles']);
}
