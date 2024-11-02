import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/model.dart';
import '../../data/repository/repository.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final authRepository = AuthRepository();

  AuthBloc() : super(AuthInitial()) {
    // on<AppStarted>(_onAppStarted);
    on<AuthLoadRememberMe>(_loadUserPreferences);
    on<AuthButtonPressed>(_onSignInButtonPressed);
    // on<LogoutRequested>(_onLogoutRequested);
    // on<SessionTimeout>(_onSessionTimeout);
  }

  // void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
  //   final status = await authRepository.status.first;
  //   if (status == UserStatus.authenticated) {
  //     emit(AuthAuthenticated());
  //   } else {
  //     emit(AuthUnauthenticated("Session Expired"));
  //   }
  // }

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
        emit(AuthAuthenticated(payload: authData.data));
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
