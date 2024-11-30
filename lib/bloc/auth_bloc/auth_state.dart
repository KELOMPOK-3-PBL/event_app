part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final AuthModel authData;
  final String? currentRole;
  // final String token;
  // final JwtPayloadModel payload;

  const AuthAuthenticated({
    required this.authData,
    this.currentRole,
  });
  // AuthAuthenticated({required this.token, required this.payload});

  @override
  List<Object?> get props => [authData, currentRole];
}

class AuthLoginRequested extends AuthState {
  final AuthModel authData;
  // final String token;
  // final JwtPayloadModel payload;

  const AuthLoginRequested({
    required this.authData,
  });
  // const AuthAuthenticated({required this.token, required this.payload});

  @override
  List<Object?> get props => [authData];
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
