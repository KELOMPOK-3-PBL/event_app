part of '../model.dart';

class AuthModel extends Equatable {
  final String status;
  final String message;
  final String? token;
  final JwtPayloadModel? data;

  // Constructor
  const AuthModel({
    required this.status,
    required this.message,
    this.token,
    this.data,
  });

  // Convert a JSON map to the AuthModel object
  factory AuthModel.fromJson(
          {required Map<String, dynamic> json,
          String? token,
          JwtPayloadModel? payload}) =>
      AuthModel(
        status: json['status'],
        message: json['message'],
        token: token,
        data: payload,
      );

  @override
  List<Object?> get props => [status, message, token, data];
}
