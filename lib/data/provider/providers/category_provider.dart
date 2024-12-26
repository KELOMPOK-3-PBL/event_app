part of '../provider.dart';

class CategoryProvider {
  final dio = getIt<Dio>();

  Future<Response> getCategoryAPI() async {
    try {
      dio.options.contentType = "application/json";
      // request get ke API
      final Response rawResponse = await dio.get('/categories');

      // Gunakan logging untuk melihat apakah header Authorization dikirim dengan benar
      // dio.interceptors
      //     .add(LogInterceptor(responseBody: true, requestBody: true));
      return rawResponse;
    } on DioException catch (e) {
      return e.response!;
    }
  }
}
