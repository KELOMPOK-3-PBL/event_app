part of '../provider.dart';

class AuthProvider {
  final dio = getIt<Dio>();

  Future<Response> authRequest(String email, String password) async {
    try {
      dio.options.contentType = "application/json";
      final Response rawResponse = await dio.post(
        '/auth',
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

  Future<Response> refreshToken(String refreshToken) async {
    try {
      dio.options.headers[HttpHeaders.authorizationHeader] =
          "Bearer $refreshToken";
      dio.options.headers[HttpHeaders.cookieHeader] = "jwt=$refreshToken";
      final Response rawResponse = await dio.post(
        '/refresh_token.php',
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
