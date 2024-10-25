part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInButtonPressed extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;

  SignInButtonPressed(this.rememberMe,
      {required this.email, required this.password});

  @override
  List<Object> get props => [email, password, rememberMe];
}
