part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthLoadRememberMe extends AuthEvent {}

class AuthCheckSession extends AuthEvent {
  final String token;

  AuthCheckSession(this.token);
}

class AuthButtonPressed extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;

  AuthButtonPressed(
      {required this.email, required this.password, required this.rememberMe});

  @override
  List<Object> get props => [email, password, rememberMe];
}

class AuthAppStarted extends AuthEvent {}

// class LogoutRequested extends AuthEvent {}

// class SessionTimeout extends AuthEvent {}
