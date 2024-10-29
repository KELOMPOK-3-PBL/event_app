part of '../provider.dart';

class AuthProvider {
  final dio = getIt<Dio>();

  Future<Response> authRequest(String email, String password) async {
    final Response rawResponse = await dio.post('/auth',
        options: Options(contentType: 'application/json'),
        data: jsonEncode({
          'email': email,
          'password': password,
        }));

    return rawResponse;
  }
}
