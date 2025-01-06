import '../../bloc/bloc.dart';
import '../../data/model/model.dart';
import '../../ui/router/router.dart';
import '../../ui/theme/ui_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class QuickCategorySection extends StatelessWidget {
  const QuickCategorySection(
      {super.key, required this.currentRole, required this.token});
  final String currentRole;
  final String token;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoaded) {
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
                      // debugPrint(currentRole);
                      // debugPrint(token);
                      Navigator.pushNamed(
                        context,
                        AppRouter.searchResultEventRoute,
                        arguments: {
                          'request_search': RequestFilteredEventModel(
                            token: token,
                            category: (currentRole == 'Member' ||
                                    currentRole == 'Propose')
                                ? categoryData[index].categoryName
                                : null,
                            status: (currentRole != 'Member' ||
                                    currentRole != 'Propose')
                                ? categoryData[index].categoryName
                                : null,
                          ),
                        },
                      );
                    },
                    child: Container(
                      // width: 90,
                      padding: EdgeInsets.symmetric(horizontal: 20),
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
          } else if (state is CategoryLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text('Category load error'),
            );
          }
        },
      ),
    );
  }
}
