// import 'package:equatable/equatable.dart';
// import 'package:event_proposal_app/data/models/category_model.dart';

part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoadded extends CategoryState {
  final List<CategoryModel> category;

  const CategoryLoadded(this.category);

  @override
  List<Object?> get props => [category];
}

class CategorySubmited extends CategoryState {
  final String nameCategory;

  const CategorySubmited(this.nameCategory);

  @override
  List<Object?> get props => [nameCategory];
}

class CategoryLoadFailure extends CategoryState {
  final String message;

  const CategoryLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}
