part of '../provider.dart';

class UserProvider {
  final dio = getIt<Dio>();

  Future<Response> getUsersAPI(String? searchUser, String token) async {
    try {
      final queryParameters = {'query': searchUser} // Menyederhanakan fungsi
        ..removeWhere((key, value) =>
            value == null); // Menghapus parameter yang bernilai null

      final Response rawResponse = await dio.get('/users.php',
          options: Options(contentType: 'application/json', headers: {
            'Authorization': 'Bearer $token',
            'Cookie': 'jwt=$token',
            'Accept': 'application/json',
            'User-Agent': 'Dart/Flutter',
          }),
          queryParameters: queryParameters);
      // debugPrint(rawResponse.toString());
      // Gunakan logging untuk melihat apakah header Authorization dikirim dengan benar
      dio.interceptors
          .add(LogInterceptor(responseBody: true, requestBody: true));
      // debugPrint("Raw response: $rawResponse.toString()");
      return rawResponse;
    } on DioException catch (e) {
      // debugPrint(e.toString());

      // debugPrint('Error response data: ${e.response}');
      return e.response!;
    }
  }
}
