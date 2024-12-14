part of '../repository.dart';

class CategoryRepository {
  final _categoryProvider = CategoryProvider();

  // Simulasi data API atau database lokal
  Future<CategoryModel> getEventsStatus() async {
    // await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    // Example data (normally fetched from API or database)
    return CategoryModel(
      status: 'success',
      code: 200,
      message: 'status',
      categories: [
        CategoryDataModel(categoryId: 1, categoryName: 'Proposed'),
        CategoryDataModel(categoryId: 2, categoryName: 'Review Admin'),
        CategoryDataModel(categoryId: 3, categoryName: 'Revision Propose'),
        CategoryDataModel(categoryId: 4, categoryName: 'Rejected'),
        CategoryDataModel(categoryId: 5, categoryName: 'Approved'),
        CategoryDataModel(categoryId: 6, categoryName: 'Completed'),
      ],
    );
  }

  // Simulasi data API atau database lokal
  Future<CategoryModel> getCategoryData() async {
    try {
      final response = await _categoryProvider.getCategoryAPI();
      final data = response.data;
      if (response.statusCode == 200
          //  && data["status"] == 'success'
          ) {
        // debugPrint(data.toString());
        return CategoryModel.fromJson(data);
        // } else if (response.statusCode == 404 || data["status"] == 'error') {
        //   return EventModel.fromJson(json: data);
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('request category failed');
      throw Exception('API REQUEST FAILED');
    }
  }
}
