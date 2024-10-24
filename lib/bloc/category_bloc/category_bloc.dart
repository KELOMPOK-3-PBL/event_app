import 'package:event_proposal_app/data/repositories/category_repository.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  // final CategoryRepository category;

  final CategoryRepository categoryRepository;

  CategoryBloc(this.categoryRepository) : super(CategoryLoading()) {
    // Trigger fetch event right when the bloc is created
    on<CategoryReadData>(_onFetchCategories);
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

  void _onFetchCategories(
      CategoryReadData event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      final categories = await categoryRepository.getCategoryData();
      emit(CategoryInitial(categories));
    } catch (e) {
      emit(CategoryLoadFailure("Failed to get categories data"));
    }
  }
}
