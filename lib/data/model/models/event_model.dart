part of '../model.dart';

class EventModel extends Equatable {
  final String tittle;
  final String category;
  final String quota;
  final String? posterUrl;
  final String place;
  final String? location;
  final String dateStart;
  final String? dateEnd;
  final String status;

  const EventModel({
    required this.tittle,
    required this.category,
    required this.quota,
    this.posterUrl,
    required this.place,
    this.location,
    required this.dateStart,
    this.dateEnd,
    required this.status,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      tittle: json['title'],
      category: json['category'],
      quota: json['quota'],
      posterUrl: json['posterUrl'],
      place: json['place'],
      location: json['location'],
      dateStart: json['dateStart'],
      status: json['status'],
    );
  }

  @override
  List<Object?> get props => [
        tittle,
        category,
        quota,
        posterUrl,
        place,
        location,
        dateStart,
        status,
      ];
}
