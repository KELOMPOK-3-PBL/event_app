part of '../repository.dart';

class AuthRepository {
  final dio = getIt<Dio>();

  // AuthRepository({required this.dio});

  Future<Map<String, dynamic>> login(
      String email, String password, bool rememberMe) async {
    try {
      await Future.delayed(Duration(seconds: 1)); // Simulate network delay
      final response = await dio.post('/authRoutes.php/login',
          options: Options(contentType: 'application/json'),
          data: jsonEncode({
            'email': email,
            'password': password,
          }));
      if (response.statusCode == 200 && response.data["status"] == 'success') {
        if (rememberMe == true) {
          saveUserPreferences(email, password);
        }
        return response.data;
      } else {
        throw Exception(
            'Error: ${response.statusCode}: ${response.data["status"]} - ${response.data["message"]}');
      }
    } catch (error) {
      throw Exception('API NOT FOUND');
    }
  }

  Future<void> saveUserPreferences(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', true);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  Future<UserPreferencesModel> loadUserPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? rememberMe = prefs.getBool('rememberMe');
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');

    return UserPreferencesModel(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
  }
}
