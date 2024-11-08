part of '../model.dart';

class RequestFilteredEventModel extends Equatable {
  final String token;
  final String currentIndex;
  final String postLimit = '5';
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
    // required this.postLimit,
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
    // String? postLimit,
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
      // postLimit: postLimit,
      status: status ?? this.status,
      category: category ?? this.category,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      search: search ?? this.search,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
    );
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
