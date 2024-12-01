import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/repository.dart';
import '../../data/model/model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final categoryRepository = CategoryRepository();

  CategoryBloc() : super(CategoryInitial()) {
    // Trigger fetch event right when the bloc is created
    on<CategoryReadData>(_onCategoryReadData);
    on<StatusReadData>(_onStatusReadData);
    // on<CategoryButtonPressed>(_onCategoryButtonPressed);
  }

  // void _onCategoryButtonPressed(
  //     CategoryButtonPressed event, Emitter<CategoryState> emit) async {
  //   // emit(CategoryLoading());
  //   try {
  //     emit(CategorySubmited(event.nameCategory));
  //   } catch (e) {
  //     emit(CategoryLoadFailure("Failed to find events with category $event"));
  //   }
  // }

  void _onCategoryReadData(
      CategoryReadData event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      final categories = await categoryRepository.getCategoryData();
      emit(CategoryLoadded(categories));
    } catch (e) {
      emit(CategoryLoadFailure("Failed to get categories data"));
    }
  }

  void _onStatusReadData(
      StatusReadData event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    try {
      final categories = await categoryRepository.getEventsStatus();
      emit(CategoryLoadded(categories));
    } catch (e) {
      emit(CategoryLoadFailure("Failed to get categories data"));
    }
  }
}
