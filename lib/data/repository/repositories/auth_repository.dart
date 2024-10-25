part of '../repository.dart';

class AuthRepository {
  final dio = getIt<Dio>();

  // AuthRepository({required this.dio});

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await dio.post('/authRoutes.php/login',
          options: Options(contentType: 'application/json'),
          data: jsonEncode({
            'email': email,
            'password': password,
          }));

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Login failed. Please try again.');
    }
  }

  Future<void> saveUserPreferences(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', true);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  Future<Map<String, dynamic>> loadUserPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? rememberMe = prefs.getBool('rememberMe');
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');

    return {
      'rememberMe': rememberMe,
      'email': email,
      'password': password,
    };
  }
}
