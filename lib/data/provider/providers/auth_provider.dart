part of '../provider.dart';

class AuthProvider {
  final dio = getIt<Dio>();

  Future<Response> authRequest(String email, String password) async {
    try {
      final Response rawResponse = await dio.post(
        '/auth.php',
        // options: Options(contentType: 'application/json'),
        data: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      // Gunakan logging untuk melihat apakah header Authorization dikirim dengan benar
      // dio.interceptors
      //     .add(LogInterceptor(responseBody: true, requestBody: true));
      // debugPrint("Raw response: $rawResponse.toString()");
      return rawResponse;
    } on DioException catch (e) {
      // debugPrint('Error response data: ${e.response}');
      return e.response!;
    }
  }
}
