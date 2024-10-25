part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String email;

  AuthSuccess(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthLoaded extends AuthState {
  final String email;
  final String password;
  final bool rememberMe;

  AuthLoaded({
    required this.email,
    required this.password,
    required this.rememberMe,
  });
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
