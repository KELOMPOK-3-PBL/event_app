import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/repository.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignInLoadUserPreference>(_loadUserPreferences);
    on<SignInButtonPressed>(_onSignInButtonPressed);
  }

  Future<void> _onSignInButtonPressed(
      SignInButtonPressed user, Emitter<AuthState> emit) async {
    // emit(AuthLoading());
    // try {
    //   await authRepository.login(user.email, user.password, user.rememberMe);
    //   // await authRepository.logIn(
    //   //     email: user.email,
    //   //     password: user.password,
    //   //     rememberMe: user.rememberMe);
    //   emit(AuthSuccess());
    // } catch (error) {
    //   emit(AuthFailure(error.toString()));
    // }
    // Future<void> login(String email, String password, bool rememberMe) async {
    emit(AuthLoading());
    try {
      await authRepository.signin(user.email, user.password, user.rememberMe);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _loadUserPreferences(
      SignInLoadUserPreference user, Emitter<AuthState> emit) async {
    try {
      final preference = await authRepository.loadUserPreferences();
      emit(AuthLoaded(
        preference.email ?? '',
        preference.password ?? '',
        preference.rememberMe ?? false,
      ));
    } catch (e) {
      emit(AuthInitial());
    }
  }
}
