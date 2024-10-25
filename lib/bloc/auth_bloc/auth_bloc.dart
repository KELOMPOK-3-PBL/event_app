import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
// import 'package:event_proposal_app/data/models/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInLoadUserPreference>(_loadUserPreferences
        as EventHandler<SignInLoadUserPreference, AuthState>);
    on<SignInButtonPressed>(_onSignInButtonPressed);
  }

  FutureOr<void> _onSignInButtonPressed(event, emit) async {
    emit(AuthLoading());
    try {
      final dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2/api-03/routes'));

      final response = await dio.post('/authRoutes.php/login',
          options: Options(contentType: 'application/json'),
          data: jsonEncode(
            {
              'email': event.email,
              'password': event.password,
            },
          ));

      if (response.statusCode == 200) {
        final jsonData = response.data;
        if (jsonData['status'] == 'success') {
          //! Only save preferences if rememberMe is true
          if (event.rememberMe == true) {
            await _saveUserPreferences(event.email, event.password);
          }
          emit(AuthSuccess(event.email));
        } else {
          emit(AuthFailure(message: jsonData['message']));
        }
      } else {
        emit(AuthFailure(message: 'Error: ${response.statusCode}'));
      }
    } catch (error) {
      emit(AuthFailure(message: 'Login failed. Please try again.'));
    }
  }

  Future<void> _saveUserPreferences(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', true);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  Future<void> _loadUserPreferences(
      SignInLoadUserPreference event, Emitter<AuthState> emit) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? rememberMe = prefs.getBool('rememberMe');
      String? email = prefs.getString('email');
      String? password = prefs.getString('password');

      if (rememberMe != null &&
          rememberMe &&
          email != null &&
          password != null) {
        emit(AuthLoaded(
            email: email, password: password, rememberMe: rememberMe));
      } else {
        emit(AuthInitial()); // Jika tidak ada data, kembali ke state awal
      }
    } catch (e) {
      emit(AuthFailure(message: "Failed to load preferences."));
    }
  }
}
