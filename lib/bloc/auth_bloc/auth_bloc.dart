import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/model.dart';
import '../../data/repository/repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authRepository = AuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<AuthAppStarted>(_onAppStarted);
    on<AuthLoadRememberMe>(_onAuthLoadRememberMe);
    on<AuthLoginRequest>(_onAuthLoginRequest);
    on<AuthLogoutRequest>(_onAuthLogoutRequest);
    // on<SessionTimeout>(_onSessionTimeout);
  }

  void _onAppStarted(AuthAppStarted event, Emitter<AuthState> emit) async {
    try {
      final authData = await _authRepository.checkAuthentication();
      // emit(AuthLoading());
      // debugPrint(authData.toString());
      if (authData?.status == 'success') {
        emit(AuthAuthenticated(authData: authData!));
      } else {
        emit(AuthUnauthenticated(message: authData!.message));
        // emit(AuthInitial());
      }
    } catch (error) {
      emit(AuthInitial());
    }
  }

  Future<void> _onAuthLoginRequest(
      AuthLoginRequest user, Emitter<AuthState> emit) async {
    // emit(AuthLoading());
    try {
      final authData = await _authRepository.login(
          user.email, user.password, user.rememberMe);
      if (authData.status == 'success') {
        emit(AuthAuthenticated(authData: authData));
      } else {
        emit(AuthUnauthenticated(message: authData.message));
      }
    } catch (error) {
      emit(AuthUnauthenticated(message: error.toString()));
    }
  }

  Future<void> _onAuthLoadRememberMe(
      AuthLoadRememberMe user, Emitter<AuthState> emit) async {
    try {
      final preference = await _authRepository.getRememberMeUserPref();
      emit(AuthRememberMeLoaded(
        preference.email ?? '',
        preference.password ?? '',
        preference.rememberMe ?? false,
      ));
    } catch (e) {
      emit(AuthInitial());
    }
  }

  void _onAuthLogoutRequest(
      AuthLogoutRequest event, Emitter<AuthState> emit) async {
    await _authRepository.logout();
    emit(AuthUnauthenticated(message: "Loging Out Success"));
    await Future.delayed(
        Duration(milliseconds: 1000)); // memastikan status diperbarui
    emit(
        AuthInitial()); // kembali ke state awal untuk menghindari masalah status di UI
  }
}
