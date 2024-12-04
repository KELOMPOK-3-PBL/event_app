part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final CategoryModel categoryData;
  final bool isCategoryEvents; // Category loaded(true), Status Loaded(false)

  const CategoryLoaded({
    required this.categoryData,
    required this.isCategoryEvents,
  });

  @override
  List<Object?> get props => [categoryData];
}

// class CategorySubmited extends CategoryState {
//   final String nameCategory;

//   const CategorySubmited(this.nameCategory);

//   @override
//   List<Object?> get props => [nameCategory];
// }

class CategoryLoadFailure extends CategoryState {
  final String message;

  const CategoryLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}
