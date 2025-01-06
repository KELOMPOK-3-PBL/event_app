part of '../model.dart';

class AuthModel extends Equatable {
  final String status;
  final String message;
  final String? accessToken;
  final String? refreshToken;
  final JwtPayloadModel? data;

  // Constructor
  const AuthModel({
    required this.status,
    required this.message,
    this.accessToken,
    this.refreshToken,
    this.data,
  });

  // Convert a JSON map to the AuthModel object
  factory AuthModel.fromJson({
    required Map<String, dynamic> json,
    String? accessToken,
    String? refreshToken,
    JwtPayloadModel? payload,
  }) =>
      AuthModel(
        status: json['status'],
        message: json['message'],
        accessToken: accessToken,
        refreshToken: refreshToken,
        data: payload,
      );

  @override
  List<Object?> get props => [status, message, accessToken, refreshToken, data];
}
