import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/model.dart';
import '../../data/repository/repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final authRepository = AuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<AuthAppStarted>(_onAppStarted);
    on<AuthLoadRememberMe>(_loadUserPreferences);
    on<AuthButtonPressed>(_onSignInButtonPressed);
    // on<LogoutRequested>(_onLogoutRequested);
    // on<SessionTimeout>(_onSessionTimeout);
  }

  void _onAppStarted(AuthAppStarted event, Emitter<AuthState> emit) async {
    final token = await authRepository.getToken();
    if (token != null) {
      try {
        final token = await authRepository.getToken();
        final payload = await authRepository.decodeToken(token!);
        // final payload = await decodeToken(data['data']['token']);
        final authData = AuthModel(
            status: 'success',
            message: 'Load login data',
            token: token,
            data: payload);
        // if (payload.expiration.isAfter(DateTime.now())) {
        emit(AuthAuthenticated(authData: authData));
        // } else {
        //   emit(AuthUnauthenticated(message: ''));
        // }
      } catch (e) {
        emit(AuthUnauthenticated(message: 'Not login yet'));
      }
    } else {
      emit(AuthUnauthenticated(message: ''));
    }
    // final status = await authRepository.status.first;
    // if (status == UserStatus.authenticated) {
    //   emit(AuthAuthenticated());
    // } else {
    //   emit(AuthUnauthenticated("Session Expired"));
    // }
  }

  Future<void> _onSignInButtonPressed(
      AuthButtonPressed user, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final authData = await authRepository.login(
          user.email, user.password, user.rememberMe);
      // await authRepository.logIn(
      //     email: user.email,
      //     password: user.password,
      //     rememberMe: user.rememberMe);
      if (authData.status == 'success') {
        emit(AuthAuthenticated(authData: authData));
      } else {
        emit(AuthUnauthenticated(message: authData.message));
      }
    } catch (error) {
      emit(AuthUnauthenticated(message: error.toString()));
    }
  }

  Future<void> _loadUserPreferences(
      AuthLoadRememberMe user, Emitter<AuthState> emit) async {
    try {
      final preference = await authRepository.loadUserPreferences();
      emit(AuthRememberMeLoaded(
        preference.email ?? '',
        preference.password ?? '',
        preference.rememberMe ?? false,
      ));
    } catch (e) {
      emit(AuthInitial());
    }
  }

  // void _onLogoutRequested(
  //     LogoutRequested event, Emitter<AuthState> emit) async {
  //   await authRepository.logout();
  //   emit(AuthUnauthenticated("Loging Out Success"));
  // }

  // void _onSessionTimeout(SessionTimeout event, Emitter<AuthState> emit) async {
  //   await authRepository.logout();
  //   emit(AuthSessionExpired());
  // }
}
