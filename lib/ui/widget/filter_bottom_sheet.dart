import 'package:event_proposal_app/bloc/bloc.dart';
import 'package:event_proposal_app/data/model/model.dart';
import 'package:event_proposal_app/ui/theme/ui_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet(
      {super.key,
      required this.token,
      required this.currentRoe,
      this.requestEvent});

  final RequestFilteredEventModel? requestEvent;
  final String token;
  final String currentRoe;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  // Filter options
  String? selectedStatus;
  String? selectedCategory;
  String? selectedDate;
  // String? dateStart;
  // String? dateEnd;
  String? sortBy;
  bool? sortOrderASC;
  RequestFilteredEventModel? requestSearch;
  List<String>? categories;

  @override
  void initState() {
    super.initState();
    if (widget.requestEvent != null) {
      selectedStatus = widget.requestEvent!.status;
      selectedCategory = widget.requestEvent!.category;
      selectedDate = widget.requestEvent!.dateFrom;
      sortBy = widget.requestEvent!.sortBy;
      sortOrderASC = (widget.requestEvent!.sortOrder == 'ASC');
      requestSearch = widget.requestEvent;
    } else {
      requestSearch = RequestFilteredEventModel(token: widget.token);
    }
    // final state = context.read<CategoryBloc>();
    // if (state is CategoryLoaded) {
    //   categories = state.categoryData.categories!;
    //   final isCategoryEvents = state.isCategoryEvents;
    // }
  }

  final List<String> statuses = [
    'Proposed',
    'Review Admin',
    'Revision Propose',
    'Rejected',
    'Approved',
    'Complete'
  ];
  final List<String> dates = ['Today', 'Tomorrow', 'This week'];
  final List<String> sortOptions = ['Started', 'Name', 'Published'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc()..add(CategoryReadData()),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Filter',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Status Filter
            if (widget.currentRoe == 'Superadmin' ||
                widget.currentRoe == 'Admin')
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: statuses.map((status) {
                    return Container(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ChoiceChip(
                        selectedColor: UIColor.primary,
                        backgroundColor: Colors.grey.shade200,
                        showCheckmark: false,
                        side: BorderSide(color: Colors.transparent),
                        label: Text(
                          status,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: (selectedStatus == status)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        selected: selectedStatus == status,
                        onSelected: (selected) {
                          setState(() {
                            selectedStatus = selected ? status : null;
                            requestSearch = requestSearch!
                                .copyWith(status: selectedStatus!);
                          });
                          // debugPrint(requestSearch.toString());
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            // SizedBox(
            //   height: 10,
            // ),
            BlocConsumer<CategoryBloc, CategoryState>(
              listener: (context, state) {
                if (state is CategoryLoaded) {
                  categories = state.categoryData.categories!
                      .map((category) => category.categoryName)
                      .toList();
                }
              },
              builder: (context, state) {
                if (state is CategoryLoaded) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: categories!.map((category) {
                        return Container(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: ChoiceChip(
                            selectedColor: UIColor.primary,
                            backgroundColor: Colors.grey.shade200,
                            showCheckmark: false,
                            side: BorderSide(color: Colors.transparent),
                            label: Text(
                              category,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: (selectedCategory == category)
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            selected: selectedCategory == category,
                            onSelected: (selected) {
                              setState(() {
                                // Membatalkan jika kategori yang sama dipilih lagi
                                selectedCategory =
                                    (selectedCategory == category)
                                        ? null
                                        : category;
                                requestSearch = requestSearch!.copyWith(
                                  category: selectedCategory,
                                );
                              });
                              debugPrint(
                                  'Selected Category: $selectedCategory');
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }

                return const SizedBox();
              },
            ),

            // const SizedBox(height: 16),
            // Time & Date
            // const Align(
            //   alignment: Alignment.centerLeft,
            //   child: Text('Time & Date',
            //       style: TextStyle(fontWeight: FontWeight.bold)),
            // ),
            // const SizedBox(height: 8),
            // Wrap(
            //   spacing: 20,
            //   children: dates.map((date) {
            //     return ChoiceChip(
            //       selectedColor: UIColor.primary,
            //       backgroundColor: Colors.grey.shade200,
            //       showCheckmark: false,
            //       side: BorderSide(color: Colors.transparent),
            //       label: Text(
            //         date,
            //         style: TextStyle(
            //             fontWeight: FontWeight.w400,
            //             color:
            //                 (selectedDate == date) ? Colors.white : Colors.black),
            //       ),
            //       selected: selectedDate == date,
            //       onSelected: (selected) {
            //         setState(() {
            //           selectedDate = selected ? date : null;
            //           // requestSearch.copyWith(dateFrom: selectedStatus);
            //         });
            //       },
            //     );
            //   }).toList(),
            // ),
            // const SizedBox(height: 8),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     ElevatedButton.icon(
            //       onPressed: () {}, // Add functionality to open calendar
            //       icon: const Icon(Icons.calendar_today),
            //       label: const Text('Calendar from'),
            //     ),
            //     ElevatedButton.icon(
            //       onPressed: () {}, // Add functionality to open calendar
            //       icon: const Icon(Icons.calendar_today),
            //       label: const Text('Calendar to'),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 16),
            const SizedBox(height: 10),
            // Sort By
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Sort by',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              children: sortOptions.map((option) {
                return ChoiceChip(
                  selectedColor: UIColor.primary,
                  backgroundColor: Colors.grey.shade200,
                  showCheckmark: false,
                  side: BorderSide(color: Colors.transparent),
                  label: Text(
                    option,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color:
                            (sortBy == option) ? Colors.white : Colors.black),
                  ),
                  selected: sortBy == option,
                  onSelected: (selected) {
                    setState(() {
                      sortBy = selected ? option : null;
                      requestSearch!.copyWith(sortBy: sortBy);
                    });
                  },
                );
              }).toList(),
            ),
            // const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              children: [
                ChoiceChip(
                  selectedColor: UIColor.primary,
                  backgroundColor: Colors.grey.shade200,
                  showCheckmark: false,
                  side: BorderSide(color: Colors.transparent),
                  label: Text(
                    'Ascending',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: (sortOrderASC == true)
                            ? Colors.white
                            : Colors.black),
                  ),
                  selected: sortOrderASC == true,
                  onSelected: (selected) {
                    setState(() {
                      // Jika Ascending dipilih, Descending dinonaktifkan
                      sortOrderASC = true;
                      requestSearch = requestSearch!.copyWith(sortOrder: 'ASC');
                    });
                    debugPrint('Sort Order: ASC');
                  },
                ),
                ChoiceChip(
                  selectedColor: UIColor.primary,
                  backgroundColor: Colors.grey.shade200,
                  showCheckmark: false,
                  side: BorderSide(color: Colors.transparent),
                  label: Text(
                    'Descending',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: (sortOrderASC == false)
                            ? Colors.white
                            : Colors.black),
                  ),
                  selected: sortOrderASC == false,
                  onSelected: (selected) {
                    setState(() {
                      // Jika Descending dipilih, Ascending dinonaktifkan
                      sortOrderASC = false;
                      requestSearch =
                          requestSearch!.copyWith(sortOrder: 'DESC');
                    });
                    debugPrint('Sort Order: ${requestSearch!.sortOrder!}');
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),
            // Action Buttons
            Flex(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: UIColor.rejected),
                    onPressed: () {
                      setState(() {
                        // Reset all filters
                        selectedCategory = null;
                        selectedStatus = null;
                        selectedDate = null;
                        sortBy = null;
                        sortOrderASC = null;
                        requestSearch =
                            RequestFilteredEventModel(token: widget.token);
                      });
                    },
                    child: const Text(
                      'Reset',
                      style: TextStyle(color: UIColor.solidWhite),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: UIColor.primary),
                    onPressed: () {
                      Navigator.pop(
                          context, requestSearch); // Apply filters and close
                    },
                    child: const Text(
                      'Apply',
                      style: TextStyle(color: UIColor.solidWhite),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
