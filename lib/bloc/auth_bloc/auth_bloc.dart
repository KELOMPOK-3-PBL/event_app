import 'dart:async';
import 'package:equatable/equatable.dart';
// import 'package:event_proposal_app/data/models/model.dart';
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
    emit(AuthLoading());
    try {
      final jsonData = await authRepository.login(user.email, user.password);

      if (jsonData['status'] == 'success') {
        if (user.rememberMe == true) {
          await authRepository.saveUserPreferences(user.email, user.password);
        }
        emit(AuthSuccess(user.email));
      } else {
        emit(AuthFailure(message: jsonData['message']));
      }
    } catch (error) {
      emit(AuthFailure(message: error.toString()));
    }
  }

  Future<void> _loadUserPreferences(
      SignInLoadUserPreference event, Emitter<AuthState> emit) async {
    try {
      final prefs = await authRepository.loadUserPreferences();

      if (prefs['rememberMe'] == true &&
          prefs['email'] != null &&
          prefs['password'] != null) {
        emit(AuthLoaded(
          email: prefs['email'],
          password: prefs['password'],
          rememberMe: prefs['rememberMe'],
        ));
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthFailure(message: "Failed to load preferences."));
    }
  }
}
