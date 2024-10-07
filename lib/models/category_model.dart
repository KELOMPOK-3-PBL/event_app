import 'package:event_proposal_app/uikit/ui_colors.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  Color boxColor;

  CategoryModel({
    required this.name,
    required this.boxColor,
  });

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];

    categories.add(CategoryModel(
      name: 'Proposed',
      boxColor: UIColor.propose,
    ));
    categories.add(CategoryModel(
      name: 'Pending',
      boxColor: UIColor.pending,
    ));
    categories.add(CategoryModel(
      name: 'Rejected',
      boxColor: UIColor.rejected,
    ));
    categories.add(CategoryModel(
      name: 'Approved',
      boxColor: UIColor.approved,
    ));

    return categories;
  }
}
