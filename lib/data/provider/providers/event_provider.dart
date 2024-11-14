part of '../provider.dart';

enum PathRequestEvents { allEvents, approvedEvents }

class EventProvider {
  final dio = getIt<Dio>();

  // Inisialisasi path
  static const String event = '/events.php';
  static const String availableEvent = '/available_events.php';

  Future<Response> getFilteredEvents(RequestFilteredEventModel pathRequest,
      PathRequestEvents getAction) async {
    try {
      String path = availableEvent;
      // final String path =
      //     (getAction == PathRequestEvents.allEvents) ? event : availableEvent;
      // String path = approvedEvents;

      var options = Options(
        contentType: 'application/json',
      );

      if (getAction == PathRequestEvents.allEvents) {
        path = event;
        // Mengatur header dengan token untuk autentikasi
        options = Options(
          contentType: 'application/json',
          headers: {
            'Cookie': 'jwt=${pathRequest.token}',
            'Authorization': 'Bearer ${pathRequest.token}',
          },
        );
      }

      // Menyusun parameter query string
      final queryParameters = pathRequest.toJson() // Menyederhanakan fungsi
        ..removeWhere((key, value) =>
            value == null); // Menghapus parameter yang bernilai null

      // Melakukan permintaan GET dengan query parameters
      final Response rawResponse = await dio.get(
        path,
        options: options,
        queryParameters: queryParameters,
      );
      // debugPrint('path: $path');
      // debugPrint('token: ${pathRequest.token}');
      debugPrint('queryParameters: $queryParameters');
      // debugPrint('Success Response data: ${rawResponse.toString()}');

      return rawResponse;
    } on DioException catch (e) {
      // debugPrint('Error response data: ${e.response.toString()}');
      return e.response!;
    }
  }

  Future<Response> getFilteredEventsByUID(
      RequestFilteredEventModel pathRequest, String uId) async {
    try {
      // Menyusun parameter query string
      final queryParameters = pathRequest.toJson() // Menyederhanakan fungsi
        ..removeWhere((key, value) =>
            value == null); // Menghapus parameter yang bernilai null

      // Add the user_id parameter
      queryParameters['user_id'] = uId;

      // Mengatur header dengan token untuk autentikasi
      final options = Options(
        contentType: 'application/json',
        headers: {
          'Authorization': pathRequest.token,
        },
      );

      // Melakukan permintaan GET dengan query parameters
      final Response rawResponse = await dio.get(
        event,
        options: options,
        queryParameters: queryParameters,
      );

      debugPrint('Success Response data: ${rawResponse.toString()}');

      return rawResponse;
    } on DioException catch (e) {
      debugPrint('Error response data: ${e.response.toString()}');
      return e.response!;
    }
  }
}
