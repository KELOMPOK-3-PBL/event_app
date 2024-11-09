part of '../provider.dart';

enum PathRequestEvents { allEvents, approvedEvents }

class EventProvider {
  final dio = getIt<Dio>();

  // Inisialisasi path
  static const String allEvents = '/events.php';
  static const String approvedEvents = '/available_events.php';

  Future<Response> getFilteredEvents(RequestFilteredEventModel pathRequest,
      PathRequestEvents getAction) async {
    try {
      // Pengecekan path request dari parameter
      final String path = (getAction == PathRequestEvents.allEvents)
          ? allEvents
          : approvedEvents;
      // String path = approvedEvents;
      // if (getAction == PathRequestEvents.allEvents) {
      //   path = allEvents;
      // }

      // Menyusun parameter query string
      final queryParameters = pathRequest.toJson() // Menyederhanakan fungsi
        ..removeWhere((key, value) =>
            value == null); // Menghapus parameter yang bernilai null

      // Mengatur header dengan token untuk autentikasi
      final options = Options(
        contentType: 'application/json',
        headers: {
          'Authorization': 'Bearer ${pathRequest.token}',
        },
      );

      // Melakukan permintaan GET dengan query parameters
      final Response rawResponse = await dio.get(
        path,
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
