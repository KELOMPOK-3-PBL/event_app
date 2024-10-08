import 'package:event_proposal_app/models/ui_colors.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  Color boxColor;

  CategoryModel({
    required this.name,
    required this.boxColor,
  });

  //! Isi Category -- nama & warna --
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

  //! model tampilan
  static getCategoryModel() {
    List<CategoryModel> categories = [];
    categories = CategoryModel.getCategories();

    return SizedBox(
      height: 30,
      // color: UIColor.propose,
      child: ListView.separated(
        itemCount: categories
            .length, // memanggil categori sesuai dengan jumlah yg ada di models
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20, right: 20),
        // membuat jarak diantara widget
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        itemBuilder: (context, index) {
          return Container(
            // height: 50,
            width: 90,
            decoration: BoxDecoration(
                color: categories[index].boxColor,
                borderRadius: BorderRadius.circular(8)),
            child: Text(categories[index].name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: UIColor.bgSolidWhite, height: 2.5, fontSize: 12)),
          );
        },
      ),
    );
  }
}
