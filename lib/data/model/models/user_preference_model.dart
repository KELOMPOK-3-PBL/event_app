part of '../model.dart';

class UserPreferencesModel extends Equatable {
  final String? email;
  final String? password;
  final bool? rememberMe;

  const UserPreferencesModel({
    required this.email,
    required this.password,
    required this.rememberMe,
  });

  @override
  List<Object?> get props => [email, password, rememberMe];
}
