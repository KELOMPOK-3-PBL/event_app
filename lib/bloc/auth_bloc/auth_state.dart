part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String? token;

  const AuthAuthenticated({this.token});

  @override
  List<Object> get props => [];
}

class AuthUserPrefenceLoaded extends AuthState {
  final String email;
  final String password;
  final bool rememberMe;

  const AuthUserPrefenceLoaded(
    this.email,
    this.password,
    this.rememberMe,
  );
}

class AuthUnauthenticated extends AuthState {
  final String message;

  const AuthUnauthenticated({required this.message});

  @override
  List<Object?> get props => [message];
}

class AuthSessionExpired extends AuthState {}
