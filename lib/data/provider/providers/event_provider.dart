part of '../provider.dart';

class EventProvider {
  final dio = getIt<Dio>();

  Future<Response> getFilteredEvents(GetEventModel requestEvent) async {
    try {
      // Menyusun parameter query string
      final queryParameters = {
        'page': requestEvent.currentIndex,
        'limit': requestEvent.postLimit,
        'status': requestEvent.status,
        'category': requestEvent.category,
        'date_from': requestEvent.dateFrom,
        'date_to': requestEvent.dateTo,
        'search': requestEvent.search,
        'sortBy': requestEvent.sortBy,
        'sort_order': requestEvent.sortOrder,
      }..removeWhere((key, value) =>
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
        '/events',
        options: options,
        queryParameters: queryParameters,
      );

      return rawResponse;
    } on DioException catch (e) {
      // print('Error response data: ${e.response}');
      return e.response!;
    }
  }
}
