part of '../provider.dart';

class EventProvider {
  final dio = getIt<Dio>();

  // Future<Response> getEvent(String currentIndex, String postLimit) async {
  //   final Response rawResponse = await dio.post('/events',
  //       options: Options(contentType: 'application/json'),
  //       data: jsonEncode({
  //         'currentIndex': currentIndex,
  //         'postLimit': postLimit,
  //       }));

  //   return rawResponse;
  // }

  Future<Response> getEvent(
    String currentIndex,
    String postLimit,
    String? status,
    String? category,
    String? sortBy,
    String? date,
  ) async {
    final Response rawResponse = await dio.post('/events',
        options: Options(contentType: 'application/json'),
        data: jsonEncode({
          'currentIndex': currentIndex,
          'postLimit': postLimit,
          'status': status,
          'category': category,
          'sortBy': sortBy,
          'date': date,
        }));

    return rawResponse;
  }
}
