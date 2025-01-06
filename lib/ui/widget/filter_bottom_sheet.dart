import 'package:event_proposal_app/data/model/model.dart';
import 'package:event_proposal_app/ui/theme/ui_colors.dart';
import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key, required this.token});

  final String token;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  // Filter options
  String? selectedStatus;
  String? selectedDate;
  String? sortBy;
  bool? isAscending;
  RequestFilteredEventModel? requestSearch;

  @override
  void initState() {
    super.initState();
    requestSearch = RequestFilteredEventModel(token: widget.token);
  }

  final List<String> statuses = [
    'Proposed',
    'Review Admin',
    'Revision Propose',
    'Rejected',
    'Approved'
  ];
  final List<String> dates = ['Today', 'Tomorrow', 'This week'];
  final List<String> sortOptions = ['Started', 'Name', 'Published'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Filter',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Status Filter
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
                        requestSearch =
                            requestSearch!.copyWith(status: selectedStatus!);
                      });
                      // debugPrint(requestSearch.toString());
                    },
                  ),
                );
              }).toList(),
            ),
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
            child:
                Text('Sort by', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 20,
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
                      color: (sortBy == option) ? Colors.white : Colors.black),
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
                      color:
                          (isAscending == true) ? Colors.white : Colors.black),
                ),
                selected: isAscending == true,
                onSelected: (selected) {
                  setState(() {
                    isAscending = selected ? true : null;
                    requestSearch!.copyWith(sortOrder: 'Ascending');
                  });
                },
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                selectedColor: UIColor.primary,
                backgroundColor: Colors.grey.shade200,
                showCheckmark: false,
                side: BorderSide(color: Colors.transparent),
                label: Text(
                  'Descending',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color:
                          (isAscending == false) ? Colors.white : Colors.black),
                ),
                selected: isAscending == false,
                onSelected: (selected) {
                  setState(() {
                    isAscending = selected ? false : null;
                    requestSearch!.copyWith(sortOrder: 'Descending');
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                onPressed: () {
                  setState(() {
                    // Reset all filters
                    selectedStatus = null;
                    selectedDate = null;
                    sortBy = null;
                    isAscending = null;
                    requestSearch =
                        RequestFilteredEventModel(token: widget.token);
                  });
                },
                child: const Text('Reset'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                      context, requestSearch); // Apply filters and close
                },
                child: const Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
