part of '../provider.dart';

enum PathRequestEvents { events, approvedEvents }

class EventProvider {
  final dio = getIt<Dio>();

  // Inisialisasi path
  static const String event = '/events.php';
  static const String availableEvent = '/available_events.php';

  Future<Response> getFilteredEvents(
      RequestFilteredEventModel request, PathRequestEvents pathRequest) async {
    try {
      String path = availableEvent;

      // Menyusun parameter query string
      final queryParameters = request.toJson() // Menyederhanakan fungsi
        ..removeWhere((key, value) =>
            value == null); // Menghapus parameter yang bernilai null

      // memperbarui path dan options bila permintaan untuk mengambil allEvents
      if (pathRequest == PathRequestEvents.events) {
        // set header untuk auth token
        dio.options.headers[HttpHeaders.authorizationHeader] =
            "Bearer ${request.token}";
        dio.options.headers[HttpHeaders.cookieHeader] = "jwt=${request.token}";
        path = event;
      }
      // Gunakan logging untuk melihat apakah header Authorization dikirim dengan benar
      dio.interceptors
          .add(LogInterceptor(responseBody: true, requestBody: true));

      // Melakukan permintaan GET dengan query parameters
      final Response rawResponse = await dio.get(
        path,
        // options: options,
        queryParameters: queryParameters,
      );

      return rawResponse;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> postEvent(String token, EventDataModel eventData) async {
    try {
      final data = await eventData.toFormData();

      dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
      dio.options.headers[HttpHeaders.cookieHeader] = "jwt=$token";

      final Response rawResponse = await dio.post(
        event,
        data: data,
      );

      // Gunakan logging untuk melihat apakah header Authorization dikirim dengan benar
      // dio.interceptors
      //     .add(LogInterceptor(responseBody: true, requestBody: true));

      return rawResponse;
    } on DioException catch (e) {
      debugPrint('Error response data: ${e.response}');
      return e.response!;
    }
  }

  Future<Response> updateEvent(
      String eventId, String token, EventDataModel eventData) async {
    try {
      final data = await eventData.toFormData();

      dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
      dio.options.headers[HttpHeaders.cookieHeader] = "jwt=$token";

      final Response rawResponse = await dio.post(
        event,
        queryParameters: {
          'event_id': eventId,
        },
        data: data,
      );

      // Gunakan logging untuk melihat apakah header Authorization dikirim dengan benar
      // dio.interceptors
      //     .add(LogInterceptor(responseBody: true, requestBody: true));

      return rawResponse;
    } on DioException catch (e) {
      debugPrint('Error response data: ${e.response}');
      return e.response!;
    }
  }

  Future<Response> getEventByID(String token, String eventId) async {
    try {
      dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
      dio.options.headers[HttpHeaders.cookieHeader] = "jwt=$token";

      // Melakukan permintaan GET dengan query parameters
      final Response rawResponse = await dio.get(
        event,
        queryParameters: {'event_id': eventId},
      );
      return rawResponse;
    } on DioException catch (e) {
      debugPrint(
          'Error response event by id $eventId. data: ${e.response.toString()}');
      return e.response!;
    }
  }
}
