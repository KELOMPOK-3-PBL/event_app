part of '../repository.dart';

class EventRepository {
  final eventProvider = EventProvider();

  Future<EventModel> getEventsFromAPI(
      {required RequestFilteredEventModel requestEvent,
      required PathRequestEvents pathRequest}) async {
    try {
      // final response = await eventProvider.getFilteredAllEvents(requestEvent);
      final response =
          await eventProvider.getFilteredEvents(requestEvent, pathRequest);
      // debugPrint("Response data: ${response.data}");

      final data = response.data;
      if (response.statusCode == 200 && data["status"] == 'success') {
        await Future.delayed(
          Duration(milliseconds: 100),
        ); // Simulate network delay

        return EventModel.fromJson(json: data);
        // } else if (response.statusCode == 404 || data["status"] == 'error') {
        //   return EventModel.fromJson(json: data);
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('API REQUEST FAILED');
    }
  }
}
