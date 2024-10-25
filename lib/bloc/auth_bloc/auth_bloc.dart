import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:event_proposal_app/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInButtonPressed>(_onSignInButtonPressed);
  }

  FutureOr<void> _onSignInButtonPressed(event, emit) async {
    emit(AuthLoading());
    try {
      const url = 'http://10.0.2.2:80/api-03/routes/authRoutes.php/login';
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': event.email, 'password': event.password}),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['status'] == 'success') {
          // Only save preferences if rememberMe is true
          if (event.rememberMe == true) {
            await _saveUserPreferences(event.email, event.password);
          }
          emit(AuthSuccess(event.email));
        } else {
          emit(AuthFailure(error: jsonData['message']));
        }
      } else {
        emit(AuthFailure(error: 'Error: ${response.statusCode}'));
      }
    } catch (error) {
      emit(AuthFailure(error: 'Login failed. Please try again.'));
    }
  }

  Future<void> _saveUserPreferences(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', true);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  // Future<void> _loadUserPreferences(String email, String password) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('rememberMe', true);
  //   await prefs.setString('email', email);
  //   await prefs.setString('password', password);
  // }
}
