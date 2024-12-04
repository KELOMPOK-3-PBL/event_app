part of '../provider.dart';

enum PathRequestEvents { events, approvedEvents }

class EventProvider {
  final dio = getIt<Dio>();

  // Inisialisasi path
  static const String event = '/events.php';
  static const String availableEvent = '/available_events.php';

  Future<Response> getFilteredEvents(RequestFilteredEventModel pathRequest,
      PathRequestEvents getAction) async {
    try {
      String path = availableEvent;

      // Menyusun parameter query string
      final queryParameters = pathRequest.toJson() // Menyederhanakan fungsi
        ..removeWhere((key, value) =>
            value == null); // Menghapus parameter yang bernilai null

      // mengatur default options
      // var options = Options(
      //   contentType: 'application/json',
      // );

      // memperbarui path dan options bila permintaan untuk mengambil allEvents
      if (getAction == PathRequestEvents.events) {
        // set header untuk auth token
        dio.options.headers[HttpHeaders.authorizationHeader] =
            "Bearer ${pathRequest.token}";
        dio.options.headers[HttpHeaders.cookieHeader] =
            "jwt=${pathRequest.token}";
        path = event;
      }
      // Gunakan logging untuk melihat apakah header Authorization dikirim dengan benar
      // dio.interceptors
      //     .add(LogInterceptor(responseBody: true, requestBody: true));

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

  // Future<Response> getEventByID(String token, String eventId) async {
  //   try {
  //     // Melakukan permintaan GET dengan query parameters
  //     final Response rawResponse = await dio.get(
  //       event,
  //       options: Options(
  //         contentType: 'application/json',
  //         headers: {
  //           'Cookie': 'jwt=$token',
  //           'Authorization': token,
  //         },
  //       ),
  //       queryParameters: {'event_id': eventId},
  //     );
  //     return rawResponse;
  //   } on DioException catch (e) {
  //     debugPrint(
  //         'Error response event by id $eventId. data: ${e.response.toString()}');
  //     return e.response!;
  //   }
  // }
}
