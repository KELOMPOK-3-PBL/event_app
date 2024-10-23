import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool rememberMe = false; // Add a rememberMe variable

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
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
            emit(LoginSuccess());
          } else {
            emit(LoginFailure(error: jsonData['message']));
          }
        } else {
          emit(LoginFailure(error: 'Error: ${response.statusCode}'));
        }
      } catch (error) {
        emit(LoginFailure(error: 'Login failed. Please try again.'));
      }
    });

    on<RememberMeToggled>((event, emit) {
      rememberMe = event.rememberMe; // Update the rememberMe variable
      emit(
          LoginInitial()); // Emit initial state; could also define a specific state if needed
    });

    on<ForgotPasswordRequested>((event, emit) {
      emit(ForgotPasswordState());
    });
  }

  Future<void> _saveUserPreferences(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', true);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  // Method to load user preferences when the bloc is initialized
  Future<void> loadUserPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    rememberMe = prefs.getBool('rememberMe') ?? false;
    // Optionally load email and password if rememberMe is true
    if (rememberMe) {
      String? email = prefs.getString('email');
      String? password = prefs.getString('password');
      // Emit some state or handle these values as needed
    }
  }
}
