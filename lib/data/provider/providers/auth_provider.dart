part of '../provider.dart';

class AuthProvider {
  final dio = getIt<Dio>();

  Future<Map<String, dynamic>> getAuthData(
      String email, String password) async {
    final response = await dio.post('/authRoutes.php/login',
        options: Options(contentType: 'application/json'),
        data: jsonEncode({
          'email': email,
          'password': password,
        }));

    final data = response.data;

    if (response.statusCode == 200 && data["status"] == 'success') {}

    return data;
  }
}
