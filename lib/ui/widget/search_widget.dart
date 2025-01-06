import 'package:flutter/material.dart';
import 'package:uicons_pro/uicons_pro.dart';

class SearchWidget extends StatefulWidget {
  final String label;
  final ValueChanged<String> onSubmittedKeyboard;
  final ValueChanged<String>? onChangedKeyboard;
  final VoidCallback? onPressedFilter;
  final bool haveFilter;
  final String? value;

  const SearchWidget({
    super.key,
    required this.label,
    required this.onSubmittedKeyboard,
    this.onPressedFilter,
    this.onChangedKeyboard,
    this.haveFilter = true,
    this.value,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.value = TextEditingValue(text: widget.value ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextField(
        onChanged: (searchQuery) {
          if (searchQuery.isNotEmpty) {
            widget.onChangedKeyboard!(searchQuery); // Passing the search query
          }
        },
        autofocus: false,
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
          hintText: widget.label, // Label
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
          suffixIcon: (widget.haveFilter)
              ? IconButton(
                  icon: Icon(
                    UIconsPro.regularRounded
                        .settings_sliders, // Using Material icons
                    color: Colors.black,
                    size: 18,
                  ),
                  onPressed: widget.onPressedFilter,
                )
              : null,
        ),
        onSubmitted: (searchQuery) {
          if (searchQuery.isNotEmpty) {
            widget.onSubmittedKeyboard(searchQuery); // Passing the search query
          }
        },
      ),
    );
  }
}
