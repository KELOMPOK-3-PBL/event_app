part of '../provider.dart';

class AuthProvider {
  final dio = getIt<Dio>();

  Future getAuthData(String email, String password) async {
    final authData = await dio.post('/authRoutes.php/login',
        options: Options(contentType: 'application/json'),
        data: jsonEncode({
          'email': email,
          'password': password,
        })) as String;

    return authData;
  }
}
