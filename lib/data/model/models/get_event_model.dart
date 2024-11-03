part of '../model.dart';

class GetEventModel extends Equatable {
  final String token;
  final String currentIndex;
  final String postLimit;
  final String? status;
  final String? category;
  final String? dateFrom;
  final String? dateTo;
  final String? search;
  final String? sortBy;
  final String? sortOrder;

  const GetEventModel({
    required this.token,
    required this.currentIndex,
    required this.postLimit,
    this.status,
    this.category,
    this.dateFrom,
    this.dateTo,
    this.search,
    this.sortBy,
    this.sortOrder,
  });

  // factory GetEventModel.fromJson(Map<String, dynamic> json) {
  //   return GetEventModel(
  //     tittle: json['title'],
  //     category: json['category'],
  //     quota: json['quota'],
  //     posterUrl: json['posterUrl'],
  //     place: json['place'],
  //     location: json['location'],
  //     dateStart: json['dateStart'],
  //     status: json['status'],
  //   );
  // }

  @override
  List<Object?> get props => [
        status,
        category,
        dateFrom,
        dateTo,
        search,
        sortBy,
        sortOrder,
      ];
}
