import 'package:event_proposal_app/bloc/category_bloc/category_bloc.dart';
import 'package:event_proposal_app/bloc/category_bloc/category_event.dart';
import 'package:event_proposal_app/bloc/category_bloc/category_state.dart';
import 'package:event_proposal_app/data/repositories/category_repository.dart';
import 'package:event_proposal_app/presentation/widget/ui_colors.dart';
import 'package:flutter/material.dart';

// class CategoryEvents {
//   String name;
//   Color boxColor;

//   CategoryEvents({
//     required this.name,
//     required this.boxColor,
//   });

//   static List<CategoryEvents> getCategories() {
//     List<CategoryEvents> categories = [];

//     categories.add(CategoryEvents(
//       name: 'Proposed',
//       boxColor: UIColor.propose,
//     ));
//     categories.add(CategoryEvents(
//       name: 'Pending',
//       boxColor: UIColor.pending,
//     ));
//     categories.add(CategoryEvents(
//       name: 'Rejected',
//       boxColor: UIColor.rejected,
//     ));
//     categories.add(CategoryEvents(
//       name: 'Approved',
//       boxColor: UIColor.approved,
//     ));

//     return categories;
//   }
// }

// class QuickCategorySection extends StatelessWidget {
//   const QuickCategorySection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<CategoryEvents> categories = CategoryEvents.getCategories();

//     return SizedBox(
//       height: 30,
//       child: ListView.separated(
//         itemCount: categories.length,
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.only(left: 20, right: 20),
//         separatorBuilder: (context, index) => const SizedBox(
//           width: 10,
//         ),
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () {
//               // Handle the button tap action here
//               print('Tapped on ${categories[index].name}'); // Example action
//             },
//             child: Container(
//               width: 90,
//               decoration: BoxDecoration(
//                   color: categories[index].boxColor,
//                   borderRadius: BorderRadius.circular(8)),
//               child: Text(categories[index].name,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                       color: UIColor.solidWhite, height: 2.5, fontSize: 12)),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';

class QuickCategorySection extends StatelessWidget {
  const QuickCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // BlocProvider(
        //   create: (context) => CategoryBloc(CategoryRepository())..add(CategoryReadData as CategoryEvent),
        //   child:
        BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryInitial) {
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
                    context
                        .read<CategoryBloc>()
                        .add(CategoryButtonPressed(state.category[index].name));
                    print('Tapped on ${state.category[index].name}');
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
          return SizedBox(
            child: Container(
              width: 90,
              decoration: BoxDecoration(
                color: UIColor.rejected,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                  "Data Category Tidak Ada", // Correct category name access
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: UIColor.solidWhite, height: 2.5, fontSize: 12)),
            ),
          ); // Return empty widget for unknown states
        }
      },
      // ),
    );
  }
}
