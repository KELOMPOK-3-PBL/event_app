part of '../model.dart';

class JwtPayloadModel extends Equatable {
  final String userId;
  final List<String> roles;
  final int issuedAt;
  final int expiration;

  const JwtPayloadModel({
    required this.userId,
    required this.roles,
    required this.issuedAt,
    required this.expiration,
  });

  // Factory method for decoding from a Map (e.g., from a decoded JSON)
  factory JwtPayloadModel.fromJson(Map<String, dynamic> json) {
    return JwtPayloadModel(
      userId: json['user_id'].toString(),
      // roles: List<String>.from(json['roles']),
      roles: List.from(json['roles']),
      issuedAt: json['iat'],
      expiration: json['exp'],
    );
  }

  @override
  List<Object?> get props => [userId, roles, issuedAt, expiration];
}
