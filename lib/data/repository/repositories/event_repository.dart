part of '../repository.dart';

class EventRepository {
  final _eventProvider = EventProvider();

  Future<EventModel> getEventsFromAPI(
      {required RequestFilteredEventModel requestEvent,
      required PathRequestEvents pathRequest}) async {
    try {
      // final response = await eventProvider.getFilteredAllEvents(requestEvent);
      final response =
          await _eventProvider.getFilteredEvents(requestEvent, pathRequest);
      // debugPrint("Response data: ${response.data}");

      final data = response.data;
      if (response.statusCode == 200 && data["status"] == 'success') {
        await Future.delayed(
          Duration(milliseconds: 100),
        ); // Simulate network delay
        EventModel dataEvent = EventModel.fromJson(json: data);

        debugPrint(dataEvent.toString());
        return dataEvent;
        // } else if (response.statusCode == 404 || data["status"] == 'error') {
        //   return EventModel.fromJson(json: data);
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('API REQUEST FAILED');
    }
  }

  Future<String> proposeEvent(String token, EventDataModel eventData) async {
    try {
      final response = await _eventProvider.postEvent(token, eventData);

      debugPrint(response.toString());
      if (response.statusCode == 200) {
        return 'Event proposed successfully';
      }
      return 'Event proposed failed';
    } catch (_) {
      throw Exception('API REQUEST FAILED');
    }
  }
}
