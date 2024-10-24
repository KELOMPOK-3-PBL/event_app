import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final Color boxColor;

  CategoryModel({required this.name, required this.boxColor});

  // Convert a JSON map to the CategoryModel object
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
      boxColor: json['colorHex'],
    );
  }

  // Convert the CategoryModel object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'colorHex': boxColor,
    };
  }
}
