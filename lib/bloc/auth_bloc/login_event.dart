import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RememberMeToggled extends LoginEvent {
  final bool rememberMe;

  RememberMeToggled({required this.rememberMe});

  @override
  List<Object> get props => [rememberMe];
}

class ForgotPasswordRequested extends LoginEvent {
  @override
  List<Object> get props => [];
}
