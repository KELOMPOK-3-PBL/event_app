part of '../model.dart';

class EventModel extends Equatable {
  final String status;
  final int code;
  final String message;
  final List<EventDataModel>? listData;
  final EventDataModel? data;

  // Constructor
  const EventModel(
      {required this.status,
      required this.code,
      required this.message,
      this.listData,
      this.data});

  // Convert a JSON map to the EventModel object
  factory EventModel.fromJson({required Map<String, dynamic> json}) =>
      EventModel(
        status: json['status'],
        code: json['code'],
        message: json['message'],
        listData: (json['data'] as List<dynamic>?)
            ?.map(
                (item) => EventDataModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );

  factory EventModel.fromJsonPropose({required Map<String, dynamic> json}) =>
      EventModel(
        status: json['status'],
        code: json['code'],
        message: json['message'],
        data: EventDataModel.fromJson(json['data']['event']),
      );
  @override
  List<Object?> get props => [status, message, listData, data];
}

class EventDataModel extends Equatable {
  final String? eventId;
  final String title;
  final String? dateAdd;
  final String? proposeUsername;
  final String? proposeAvatar;
  final String? categoryId;
  final String? category;
  final String description;
  final String? posterUrl;
  final File? imagePoster;
  final String? location;
  final String place;
  final int quota;
  final String dateStart;
  final String? dateEnd;
  final String? schedule;
  final String? adminUsername;
  final String? updated;
  final String? status;
  final String? adminNote;
  // final String? invitedPersons;
  final List<InvitedPerson>? invitedPersons;

  const EventDataModel({
    this.eventId,
    required this.title,
    this.dateAdd,
    this.proposeUsername,
    this.proposeAvatar,
    this.categoryId,
    this.category,
    required this.description,
    this.posterUrl,
    this.imagePoster,
    this.location,
    required this.place,
    required this.quota,
    required this.dateStart,
    this.dateEnd,
    this.schedule,
    this.adminUsername,
    this.updated,
    this.status,
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

  Future<FormData> toFormData() async {
    final Map<String, dynamic> data = {
      'event_id': eventId,
      'title': title,
      'date_add': dateAdd,
      'propose_user': proposeUsername,
      'propose_user_avatar': proposeAvatar,
      'category_id': categoryId,
      'description': description,
      // 'poster': base64Encode(await imagePoster!.readAsBytes()),
      'poster': await MultipartFile.fromFile(imagePoster!.path),
      'location': location,
      'place': place,
      'quota': quota,
      'date_start': dateStart,
      'date_end': dateEnd,
      'schedule': schedule,
      'admin_user': adminUsername,
      'updated': updated,
      'status': status,
      'note': adminNote,
      'invited_users': invitedPersons,
    };

    // Hapus key dengan nilai null
    data.removeWhere((key, value) => value == null);

    return FormData.fromMap(data);
  }

  @override
  List<Object?> get props => [
        eventId,
        title,
        dateAdd,
        proposeUsername,
        proposeAvatar,
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
        invitedPersons,
      ];
}

class InvitedPerson extends Equatable {
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

  @override
  List<Object?> get props => [username, avatar];
}
