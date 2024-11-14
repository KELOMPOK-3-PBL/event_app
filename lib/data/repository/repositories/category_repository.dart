part of '../repository.dart';

class CategoryRepository {
  // Simulasi data API atau database lokal
  Future<List<CategoryModel>> getEventsStatus() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    // Example data (normally fetched from API or database)
    return [
      CategoryModel(name: 'Proposed', boxColor: UIColor.propose),
      CategoryModel(name: 'Reviewing', boxColor: UIColor.reviewing),
      CategoryModel(name: 'Pending', boxColor: UIColor.pending),
      CategoryModel(name: 'Rejected', boxColor: UIColor.rejected),
      CategoryModel(name: 'Approved', boxColor: UIColor.approved),
      CategoryModel(name: 'Complete', boxColor: UIColor.admin),
    ];
  }

  // Simulasi data API atau database lokal
  Future<List<CategoryModel>> getCategoryData() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    // try {
    //   final response = await dio.post('/authRoutes.php/login',
    //       options: Options(contentType: 'application/json'),
    //       data: jsonEncode(
    //         {
    //           'email': event.email,
    //           'password': event.password,
    //         },
    //       ));

    // } catch (error) {
    //   AuthFailure(message: 'Login failed. Please try again.');
    // }

    // Example data (normally fetched from API or database)
    return [];
  }
}
