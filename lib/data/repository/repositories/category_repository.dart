import 'package:event_proposal_app/presentation/widget/ui_colors.dart';
import 'package:event_proposal_app/data/model/model.dart';

import 'dart:convert';
import 'package:dio/dio.dart';

import '../../../bloc/bloc.dart';

class CategoryRepository {
  // Simulasi data API atau database lokal
  Future<List<CategoryModel>> getCategoryData() async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    // Example data (normally fetched from API or database)
    return [
      CategoryModel(name: 'Proposed', boxColor: UIColor.propose),
      CategoryModel(name: 'Pending', boxColor: UIColor.pending),
      CategoryModel(name: 'Rejected', boxColor: UIColor.rejected),
      CategoryModel(name: 'Approved', boxColor: UIColor.approved),
      CategoryModel(name: 'Complete', boxColor: UIColor.typoGray),
    ];
  }
}

class StatusRepository {
  final dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2/api-03/routes'));

  // Simulasi data API atau database lokal
  Future<List<CategoryModel>> getCategoryData(dynamic event) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    // try {
    //   final dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2/api-03/routes'));

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
    return [
      CategoryModel(name: 'Proposed', boxColor: UIColor.propose),
      CategoryModel(name: 'Pending', boxColor: UIColor.pending),
      CategoryModel(name: 'Rejected', boxColor: UIColor.rejected),
      CategoryModel(name: 'Approved', boxColor: UIColor.approved),
      CategoryModel(name: 'Complete', boxColor: UIColor.typoGray),
    ];
  }
}
