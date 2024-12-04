part of '../model.dart';

class RequestFilteredEventModel extends Equatable {
  final String token;
  final String currentIndex;
  // final String? proposeUserId;
  final String? adminUserId;
  // static const String postLimit = "5";
  final String? postLimit;
  final String? eventId;
  final String? status;
  final String? category;
  final String? dateFrom;
  final String? dateTo;
  final String? search;
  final String? sortBy;
  final String? sortOrder;

  const RequestFilteredEventModel({
    required this.token,
    required this.currentIndex,
    // this.proposeUserId,
    this.adminUserId,
    this.postLimit = '5',
    this.eventId,
    this.status,
    this.category,
    this.dateFrom,
    this.dateTo,
    this.search,
    this.sortBy,
    this.sortOrder,
  });

  RequestFilteredEventModel copyWith({
    String? token,
    String? currentIndex,
    String? postLimit,
    String? eventId,
    String? status,
    String? category,
    String? dateFrom,
    String? dateTo,
    String? search,
    String? sortBy,
    String? sortOrder,
  }) {
    return RequestFilteredEventModel(
      token: token ?? this.token,
      currentIndex: currentIndex ?? this.currentIndex,
      postLimit: postLimit ?? this.postLimit,
      eventId: eventId ?? this.eventId,
      status: status ?? this.status,
      category: category ?? this.category,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      search: search ?? this.search,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  // Convert the CategoryModel object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'offset': currentIndex,
      // 'propose_uid': proposeUserId,
      'admin_user_id': adminUserId,
      'limit': postLimit,
      'status': status,
      'category': category,
      'date_from': dateFrom,
      'date_to': dateTo,
      'search': search,
      'sortBy': sortBy,
      'sort_order': sortOrder,
    };
  }

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
