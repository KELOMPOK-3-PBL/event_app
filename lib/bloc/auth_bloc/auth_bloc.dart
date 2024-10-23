import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool rememberMe = false; // Add a rememberMe variable

  AuthBloc() : super(AuthInitial()) {
    on<SignInButtonPressed>((event, emit) async {
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
            if (rememberMe) {
              await _saveUserPreferences(event.email, event.password);
            }
            emit(AuthSuccess());
          } else {
            emit(AuthFailure(error: jsonData['message']));
          }
        } else {
          emit(AuthFailure(error: 'Error: ${response.statusCode}'));
        }
      } catch (error) {
        emit(AuthFailure(error: 'Login failed. Please try again.'));
      }
    });
  }

  Future<void> _saveUserPreferences(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      await prefs.setBool('rememberMe', true);
      await prefs.setString('email', email);
      await prefs.setString('password', password);
    } else {
      await prefs.remove('rememberMe');
      await prefs.remove('email');
      await prefs.remove('password');
    }
  }
}
