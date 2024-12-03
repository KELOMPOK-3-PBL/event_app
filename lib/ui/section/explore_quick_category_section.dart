import '../../bloc/bloc.dart';
import '../../ui/router/router.dart';
import '../../ui/theme/ui_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class QuickCategorySection extends StatelessWidget {
  const QuickCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoadded) {
          final categoryData = state.categoryData.categories!;
          final isCategoryEvents = state.isCategoryEvents;

          return SizedBox(
            height: 30,
            child: ListView.separated(
              itemCount: categoryData.length, // Correct item count
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20, right: 20),
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, AppRouter.searchResultEventRoute, arguments: {
                      "category_name": categoryData[index].categoryName
                    });
                  },
                  child: Container(
                    width: 90,
                    decoration: BoxDecoration(
                      color: UIColor.getStatusColor(
                          categoryData[index].categoryName),
                      borderRadius: BorderRadius.circular(
                          (isCategoryEvents == true) ? 24 : 8),
                      border: (isCategoryEvents == true)
                          ? Border.all(color: UIColor.primary)
                          : null,
                    ),
                    child: Text(
                        categoryData[index]
                            .categoryName, // Correct category name access
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: (isCategoryEvents == true)
                                ? UIColor.primary
                                : UIColor.solidWhite,
                            height: 2.5,
                            fontSize: 12)),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
