part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final JwtPayloadModel? payload;

  const AuthAuthenticated({required this.payload});
  @override
  List<Object> get props => [];
}

class AuthRememberMeLoaded extends AuthState {
  final String email;
  final String password;
  final bool rememberMe;

  const AuthRememberMeLoaded(
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

// class AuthSessionExpired extends AuthState {}
