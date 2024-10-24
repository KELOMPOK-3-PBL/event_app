import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/category_repository.dart';
import '../../data/models/category_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  // final CategoryRepository category;

  final CategoryRepository categoryRepository;

  CategoryBloc({required this.categoryRepository}) : super(CategoryInitial()) {
    // Trigger fetch event right when the bloc is created
    on<CategoryReadData>(_onInitialCategories);
    on<CategoryButtonPressed>(_onCategoryButtonPressed);
  }

  void _onCategoryButtonPressed(
      CategoryButtonPressed event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      emit(CategorySubmited(event.nameCategory));
    } catch (e) {
      emit(CategoryLoadFailure("Failed to find events with category $event"));
    }
  }

  void _onInitialCategories(
      CategoryReadData event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      final categories = await categoryRepository.getCategoryData();
      emit(CategoryLoadded(categories));
    } catch (e) {
      emit(CategoryLoadFailure("Failed to get categories data"));
    }
  }
}
