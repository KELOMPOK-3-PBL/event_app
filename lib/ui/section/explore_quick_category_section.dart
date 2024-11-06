import 'package:event_proposal_app/bloc/bloc.dart';
import 'package:event_proposal_app/ui/router/go_router.dart';

import 'package:event_proposal_app/ui/screen/search_result_event_screen.dart';
import 'package:event_proposal_app/ui/widget/ui_colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class QuickCategorySection extends StatelessWidget {
  const QuickCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
      if (state is CategoryLoading) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(child: CircularProgressIndicator());
          },
        );
      } else if (state is CategorySubmited) {
        GoRouter.of(context).goNamed(
          'search_result_events',
          queryParameters: {'searchQuery': state.nameCategory},
        );
        // GoRouter.of(context).pop();
        // Navigator.of(context).pop(); // Close loading spinner
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) =>
        //           SearchResultEventsScreen(searchQuery: state.nameCategory)),
        // );
        //! Trigger CategoryBloc untuk memuat ulang data kategori
        // context.read<CategoryBloc>().add(StatusReadData());
      } else if (state is CategoryLoadded) {
        // Navigator.of(context).pop();
        context.pop();
      }
    }, builder: (context, state) {
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
                      state
                          .category[index].name, // Correct category name access
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
      }
      return SizedBox();
    });
  }
}
