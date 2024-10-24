// import 'package:equatable/equatable.dart';
// import 'package:event_proposal_app/data/models/category_model.dart';

part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
  @override
  List<Object?> get props => [];
}

class CategoryReadData extends CategoryEvent {
  // final List<CategoryModel> categories;

  // const CategoryReadData(categoryModel, this.categories);

  // @override
  // List<Object?> get props => [categories];
}

class CategoryButtonPressed extends CategoryEvent {
  final String nameCategory;

  const CategoryButtonPressed(this.nameCategory);

  @override
  List<Object?> get props => [nameCategory];
}
