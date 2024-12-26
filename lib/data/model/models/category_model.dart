part of '../model.dart';

class CategoryModel extends Equatable {
  final String status;
  final int? code;
  final String message;
  final List<CategoryDataModel>? categories;

  const CategoryModel({
    required this.status,
    required this.code,
    required this.message,
    this.categories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      categories: (json['data'] as List<dynamic>?)
          ?.map((category) => CategoryDataModel.fromJson(category))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [status, code, message, categories];
}

class CategoryDataModel extends Equatable {
  final int categoryId;
  final String categoryName;

  const CategoryDataModel({
    required this.categoryId,
    required this.categoryName,
  });

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) {
    return CategoryDataModel(
      categoryId: json['category_id'],
      categoryName: json['category_name'],
    );
  }

  @override
  List<Object?> get props => [categoryId, categoryName];
}
