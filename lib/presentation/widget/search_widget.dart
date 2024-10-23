import 'package:flutter/material.dart';
import 'package:uicons_pro/uicons_pro.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final String label;
  final ValueChanged<String> onSubmittedKeyboard;
  final VoidCallback onPressedFilter;

  SearchWidget(
      {super.key,
      required this.label,
      required this.onSubmittedKeyboard,
      required this.onPressedFilter});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextField(
        controller: _searchController, // Assigning the controller
        textInputAction: TextInputAction.search,
        maxLines: 1,
        minLines: 1,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          isDense: true,
          alignLabelWithHint: true,
          hintText: label, // Label
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
          hintStyle: const TextStyle(
              color: Colors.grey, fontSize: 14), // Adjusted color
          filled: true,
          fillColor: Colors.white, // Adjusted color
          prefixIcon: Icon(
            UIconsPro.regularRounded.search, // Using Material icons
            color: Colors.black,
            size: 18,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              UIconsPro.regularRounded.settings_sliders, // Using Material icons
              color: Colors.black,
              size: 18,
            ),
            onPressed: onPressedFilter,
          ),
        ),
        onSubmitted: (searchQuery) {
          if (searchQuery.isNotEmpty) {
            onSubmittedKeyboard(searchQuery); // Passing the search query
          }
        },
      ),
    );
  }

  String getSearchValue() {
    return _searchController.text; // Now this returns the correct value
  }
}
