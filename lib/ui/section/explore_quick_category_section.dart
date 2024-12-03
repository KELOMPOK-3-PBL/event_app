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
          return SizedBox(
            height: 30,
            child: ListView.separated(
              itemCount: state.category.length, // Correct item count
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
                      "search_query": state.category[index].name
                    });
                  },
                  child: Container(
                    width: 90,
                    decoration: BoxDecoration(
                      color: state.category[index].boxColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                        state.category[index]
                            .name, // Correct category name access
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: UIColor.solidWhite,
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
