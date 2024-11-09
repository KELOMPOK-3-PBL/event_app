part of '../provider.dart';

class EventProvider {
  final dio = getIt<Dio>();

  Future<Response> getFilteredAllEvents(
      RequestFilteredEventModel requestEvent) async {
    try {
      // Menyusun parameter query string
      final queryParameters = requestEvent.toJson() // Menyederhanakan fungsi
        ..removeWhere((key, value) =>
            value == null); // Menghapus parameter yang bernilai null

      // Mengatur header dengan token untuk autentikasi
      final options = Options(
        contentType: 'application/json',
        headers: {
          'Authorization': 'Bearer ${requestEvent.token}',
        },
      );

      // Melakukan permintaan GET dengan query parameters
      final Response rawResponse = await dio.get(
        '/events.php',
        options: options,
        queryParameters: queryParameters,
      );
      // debugPrint('Success Response data: ${rawResponse.toString()}');

      return rawResponse;
    } on DioException catch (e) {
      // debugPrint('Error response data: ${e.response.toString()}');
      return e.response!;
    }
  }

  Future<Response> getFilteredApprovedEvents(
      RequestFilteredEventModel requestEvent) async {
    try {
      // Menyusun parameter query string
      final queryParameters = requestEvent.toJson() // Menyederhanakan fungsi
        ..removeWhere((key, value) =>
            value == null); // Menghapus parameter yang bernilai null

      // Mengatur header dengan token untuk autentikasi
      final options = Options(
        contentType: 'application/json',
        headers: {
          'Authorization': 'Bearer ${requestEvent.token}',
        },
      );

      // Melakukan permintaan GET dengan query parameters
      final Response rawResponse = await dio.get(
        '/available_events.php',
        options: options,
        queryParameters: queryParameters,
      );
      // debugPrint('Success Response data: ${rawResponse.toString()}');

      return rawResponse;
    } on DioException catch (e) {
      // debugPrint('Error response data: ${e.response.toString()}');
      return e.response!;
    }
  }
}
