import 'dart:async';
// import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:stream_transform/stream_transform.dart';

import '../../data/model/model.dart';
import '../../data/repository/repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

// const throttleDuration = Duration(milliseconds: 100);

// EventTransformer<E> throttleDroppable<E>(Duration duration) {
//   return (events, mapper) {
//     return droppable<E>().call(events.throttle(duration), mapper);
//   };
// }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authRepository = AuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<AuthAppStarted>(_onAppStarted);
    on<AuthSaveCurrentRole>(_onSaveCurrentRole);
    on<AuthLoadRememberMe>(_onAuthLoadRememberMe);
    on<AuthLoginRequest>(_onAuthLoginRequest);
    on<AuthLogoutRequest>(_onAuthLogoutRequest);
    // on<SessionTimeout>(_onSessionTimeout);
  }

  Future<void> _onAppStarted(
      AuthAppStarted event, Emitter<AuthState> emit) async {
    try {
      // emit(AuthLoading());
      final authData = await _authRepository.checkAuthentication();
      // debugPrint(authData.toString());
      if (authData?.status == 'success') {
        final currentRole = await _authRepository.getCurretRole();
        emit(AuthAuthenticated(authData: authData!, currentRole: currentRole));
      } else {
        emit(AuthUnauthenticated(
          message: authData!.message,
        ));
        // emit(AuthInitial());
      }
    } catch (error) {
      emit(AuthInitial());
    }
  }

  Future<void> _onSaveCurrentRole(
      AuthSaveCurrentRole event, Emitter<AuthState> emit) async {
    debugPrint(
        "Event received: AuthSaveCurrentRole with role: ${event.currentRole}");
    try {
      final authState = state as AuthAuthenticated;
      if (state is AuthAuthenticated
          //  && authState.currentRole == null
          ) {
        final String currentRole = event.currentRole;
        // emit(AuthLoading());
        debugPrint(currentRole);
        await _authRepository.saveCurrentRole(event.currentRole);
        emit(AuthAuthenticated(
            currentRole: currentRole, authData: authState.authData));
      } else {
        debugPrint("Ignored: Current state is not AuthAuthenticated.");
        // emit(AuthAuthenticated(authData: authState.authData));
        emit(AuthUnauthenticated(message: "No role selected"));
      }
    } catch (e, stackTrace) {
      debugPrint("Error in _onSaveCurrentRole: $e");
      debugPrintStack(stackTrace: stackTrace);
      emit(AuthInitial());
    }
  }

  Future<void> _onAuthLoginRequest(
      AuthLoginRequest user, Emitter<AuthState> emit) async {
    // emit(AuthLoading());
    try {
      final AuthModel authData = await _authRepository.login(
          user.email, user.password, user.rememberMe);
      if (authData.status == 'success') {
        if (authData.data!.roles.length == 1 &&
            authData.data!.roles.contains('Member')) {
          emit(AuthLoading());
          return emit(AuthUnauthenticated(
            message: "Member user can't login with this app",
          ));
        }
        emit(AuthAuthenticated(authData: authData));
        // emit(AuthLoginRequested(authData: authData));
      } else {
        emit(AuthLoading());

        emit(AuthUnauthenticated(message: authData.message));
      }
    } catch (error) {
      emit(AuthLoading());

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

  Future<void> _onAuthLogoutRequest(
      AuthLogoutRequest event, Emitter<AuthState> emit) async {
    await _authRepository.logout();
    emit(AuthUnauthenticated(message: "Loging Out Succes"));
    await Future.delayed(
        Duration(milliseconds: 1000)); // memastikan status diperbarui
    emit(
        AuthInitial()); // kembali ke state awal untuk menghindari masalah status di UI
  }
}
