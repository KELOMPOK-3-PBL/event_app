part of '../service.dart';

//! Digunakan untuk menghubungkan ke API
class AuthService {
  final dio = getIt<Dio>();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/authRoutes.php/login',
        options: Options(contentType: 'application/json'),
        data: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200 && response.data["status"] == 'success') {
        return response.data;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('API NOT FOUND');
    }
  }
}
