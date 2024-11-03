part of '../model.dart';

class CategoryModel extends Equatable {
  final String name;
  final Color? boxColor;

  // Constructor
  const CategoryModel({required this.name, this.boxColor});

  // Convert a JSON map to the CategoryModel object
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
      boxColor: Color(int.parse(json['colorHex'], radix: 16)).withOpacity(1.0),
    );
  }

  // Convert the CategoryModel object to a JSON map
  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'colorHex': boxColor.value.toRadixString(16),
  //   };
  // }

  @override
  List<Object?> get props => [name, boxColor];
}
