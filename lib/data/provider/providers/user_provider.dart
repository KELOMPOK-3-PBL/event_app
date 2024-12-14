part of '../provider.dart';

class UserProvider {
  final dio = getIt<Dio>();

  Future<Response> getUsersAPI({
    String? userId,
    String? searchUser,
    required String token,
    int? offset,
    int? limit,
  }) async {
    try {
      final queryParameters = {
        'query': searchUser,
        'user_id': userId,
        'offset': offset,
        'limit': limit,
      } // Menyederhanakan fungsi
        ..removeWhere((key, value) =>
            value == null); // Menghapus parameter yang bernilai null
      dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
      dio.options.headers[HttpHeaders.cookieHeader] = "jwt=$token";
      dio.options.contentType = "application/json";

      // request get ke API
      final Response rawResponse = await dio.get('/users.php',
          // options: Options(contentType: 'application/json', headers: {
          //   'Authorization': 'Bearer $token',
          //   'Cookie': 'jwt=$token',
          //   'Accept': 'application/json',
          //   'User-Agent': 'Dart/Flutter',
          // }),
          queryParameters: queryParameters);
      // debugPrint(rawResponse.toString());
      // Gunakan logging untuk melihat apakah header Authorization dikirim dengan benar
      // dio.interceptors
      //     .add(LogInterceptor(responseBody: true, requestBody: true));
      // debugPrint("Raw response: $rawResponse.toString()");
      return rawResponse;
    } on DioException catch (e) {
      // debugPrint(e.toString());

      // debugPrint('Error response data: ${e.response}');
      return e.response!;
    }
  }
}
