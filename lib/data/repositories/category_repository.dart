import 'package:event_proposal_app/data/models/category_model.dart';
import 'package:event_proposal_app/presentation/widget/ui_colors.dart';

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
    ];
  }
}
