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
        data: (json['data'] as List<dynamic>?)
            ?.map(
                (item) => EventDataModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );

  @override
  List<Object?> get props => [status, message, data!];
}

class EventDataModel extends Equatable {
  final String eventId;
  final String title;
  final String dateAdd;
  final String proposeUsername;
  final String? proposeAvatar;
  final String category;
  final String description;
  final String? posterUrl;
  final String? location;
  final String place;
  final int quota;
  final String dateStart;
  final String? dateEnd;
  final String? schedule;
  final String? adminUsername;
  final String? updated;
  final String status;
  final String? adminNote;
  // final String? invitedPersons;
  final List<InvitedPerson>? invitedPersons;

  const EventDataModel({
    required this.eventId,
    required this.title,
    required this.dateAdd,
    required this.proposeUsername,
    this.proposeAvatar,
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
    this.invitedPersons,
  });

  factory EventDataModel.fromJson(Map<String, dynamic> json) {
    return EventDataModel(
      eventId: json['event_id'].toString(),
      title: json['title'],
      dateAdd: json['date_add'],
      proposeUsername: json['propose_user'],
      proposeAvatar: json['propose_user_avatar'],
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
      // invitedPersons: json['invited_users'].toString(),

      invitedPersons: (json['invited_users'] as List?)
          ?.map((user) => InvitedPerson.fromJson(user))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
        // eventId,
        // title,
        // dateAdd,
        // proposeUsername,
        // proposeAvatar!,
        // category,
        // description,
        // posterUrl!,
        // location!,
        // place,
        // quota,
        // dateStart,
        // dateEnd!,
        // schedule!,
        // adminUsername!,
        // updated!,
        // status,
        // adminNote!,
      ];
}

class InvitedPerson {
  final String username;
  final String? avatar;

  // Constructor
  const InvitedPerson({
    required this.username,
    this.avatar,
  });

  // Convert a JSON map to the InvitedPerson object
  factory InvitedPerson.fromJson(Map<String, dynamic> json) {
    return InvitedPerson(
      username: json['username'],
      avatar: json['avatar'],
    );
  }
}
