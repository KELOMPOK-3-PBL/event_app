import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInButtonPressed extends AuthEvent {
  final String email;
  final String password;

  SignInButtonPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
