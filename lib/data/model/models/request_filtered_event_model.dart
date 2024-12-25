part of '../model.dart';

class RequestFilteredEventModel
//  extends Equatable
{
  final String token;
  final int currentIndex;
  // final String? proposeUserId;
  final String? adminUserId;
  // static const String postLimit = "5";
  final int? postLimit;
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
    this.currentIndex = 0,
    // this.proposeUserId,
    this.adminUserId,
    this.postLimit = 5,
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
    int? currentIndex,
    int? postLimit,
    String? adminUserId,
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
      adminUserId: adminUserId ?? this.adminUserId,
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
    final data = {
      'offset': currentIndex,
      'admin_user_id': adminUserId,
      'limit': postLimit,
      'event_id': eventId,
      'status': status,
      'category': category,
      'date_from': dateFrom,
      'date_to': dateTo,
      'search': search,
      'sortBy': sortBy,
      'sort_order': sortOrder,
    };

    // Menghapus semua nilai `null`
    data.removeWhere((key, value) => value == null);

    return data;
  }

  @override
  List<Object?> get props => [
        token,
        adminUserId,
        postLimit,
        eventId,
        status,
        category,
        dateFrom,
        dateTo,
        search,
        sortBy,
        sortOrder,
      ];
}
