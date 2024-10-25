part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInLoadUserPreference extends AuthEvent {}

class SignInButtonPressed extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;

  SignInButtonPressed(
      {required this.email, required this.password, required this.rememberMe});

  @override
  List<Object> get props => [email, password, rememberMe];
}
