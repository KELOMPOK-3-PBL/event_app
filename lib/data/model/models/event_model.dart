part of '../model.dart';

class EventModel extends Equatable {
  final String status;
  final String message;
  final List<EventDataModel>? data;

  // Constructor
  const EventModel({
    required this.status,
    required this.message,
    this.data,
  });

  // Convert a JSON map to the EventModel object
  factory EventModel.fromJson({required Map<String, dynamic> json}) =>
      EventModel(
        status: json['status'],
        message: json['message'],
        data: json['data'],
      );

  @override
  List<Object?> get props => [status, message, data];
}

class EventDataModel extends Equatable {
  final String eventId;
  final String title;
  final String dateAdd;
  final String proposeUsername;
  final String category;
  final String description;
  final String? posterUrl;
  final String? location;
  final String place;
  final String quota;
  final String dateStart;
  final String? dateEnd;
  final String? schedule;
  final String? adminUsername;
  final String? updated;
  final String status;
  final String? adminNote;

  const EventDataModel({
    required this.eventId,
    required this.title,
    required this.dateAdd,
    required this.proposeUsername,
    required this.category,
    required this.description,
    this.posterUrl,
    this.location,
    required this.place,
    required this.quota,
    required this.dateStart,
    this.dateEnd,
    this.schedule,
    this.adminUsername,
    this.updated,
    required this.status,
    this.adminNote,
  });

  factory EventDataModel.fromJson(Map<String, dynamic> json) {
    return EventDataModel(
      eventId: json['event_id'],
      title: json['title'],
      dateAdd: json['date_add'],
      proposeUsername: json['propose_user'],
      category: json['category'],
      description: json['description'],
      posterUrl: json['poster'],
      location: json['location'],
      place: json['place'],
      quota: json['quota'],
      dateStart: json['date_start'],
      dateEnd: json['date_end'],
      schedule: json['schedule'],
      adminUsername: json['admin_user'],
      updated: json['updated'],
      status: json['status'],
      adminNote: json['note'],
    );
  }

  @override
  List<Object?> get props => [
        eventId,
        title,
        dateAdd,
        proposeUsername,
        category,
        description,
        posterUrl,
        location,
        place,
        quota,
        dateStart,
        dateEnd,
        schedule,
        adminUsername,
        updated,
        status,
        adminNote,
      ];
}
