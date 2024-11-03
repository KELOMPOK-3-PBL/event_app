part of '../provider.dart';

class EventProvider {
  final dio = getIt<Dio>();

  Future<Response> getFilteredEvents(GetEventModel requestEvent) async {
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
      headers: {
        'Authorization': 'Bearer ${requestEvent.token}',
        'Content-Type': 'application/json',
      },
    );

    // Melakukan permintaan GET dengan query parameters
    final Response rawResponse = await dio.get(
      '/events',
      options: options,
      queryParameters: queryParameters,
    );

    return rawResponse;
  }
}
