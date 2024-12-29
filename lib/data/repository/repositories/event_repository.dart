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

      final data = response.data;
      if (response.statusCode == 200 && data["status"] == 'success') {
        await Future.delayed(
          Duration(milliseconds: 100),
        ); // Simulate network delay
        EventModel dataEvent = EventModel.fromJson(json: data);

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

  Future<Map<String, dynamic>> proposeEvent(
      String token, EventDataModel eventData) async {
    try {
      final response = await _eventProvider.createEvent(token, eventData);

      // debugPrint(response.data['data'].toString());

      return {
        'code': response.statusCode,
        'status': response.data['status'],
        'message': response.data['message'],
        'event_id': response.data['data']['event']['event_id'].toString(),
      };
    } catch (_) {
      throw Exception('Failed to propose event');
    }
  }

  Future<Map<String, dynamic>> updateEvent(
      String token, EventDataModel eventData, String currentRole) async {
    try {
      final response =
          await _eventProvider.updateEvent(token, eventData, currentRole);
      debugPrint(response.toString());
      return {
        // 'code': response.statusCode,
        'status': response.data['status'],
        'message': response.data['message'],
      };
    } catch (_) {
      throw Exception('Failed to update event');
    }
  }

  Future<EventModel> getEventByIDFromAPI(
      {required String token, required String eventId}) async {
    try {
      final response = await _eventProvider.getEventByID(token, eventId);
      return EventModel.fromJsonSingeEvent(json: response.data);
    } catch (_) {
      throw Exception('API REQUEST FAILED');
    }
  }

  Future<Map<String, dynamic>> deleteEventFromAPI(
      {required String token, required String eventId}) async {
    try {
      final response = await _eventProvider.deleteEvent(token, eventId);
      debugPrint(response.toString());
      return {
        'status': response.data['status'],
        'message': response.data['message'],
      };
    } catch (_) {
      throw Exception('Failed to delete event');
    }
  }
}
