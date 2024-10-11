import 'package:event_proposal_app/models/ui_colors.dart';
import 'package:uicons/uicons.dart';
import 'package:flutter/material.dart';

class SearchEventsWidget extends StatefulWidget {
  const SearchEventsWidget({super.key});

  @override
  SearchEventsWidgetState createState() => SearchEventsWidgetState();
}

class SearchEventsWidgetState extends State<SearchEventsWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextField(
        controller: _searchController,
        maxLines: 1,
        minLines: 1,
        decoration: InputDecoration(
          isDense: true,
          alignLabelWithHint: true,
          hintText: 'Search event..',
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
          hintStyle: const TextStyle(color: UIColor.typoGray, fontSize: 14),
          prefixIcon: Icon(
            UIcons.regularRounded.search,
            color: UIColor.typoBlack,
            size: 18,
          ),
          suffixIcon: Icon(
            UIcons.regularRounded.settings_sliders,
            color: UIColor.typoBlack,
            size: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: UIColor.bgSolidWhite,
        ),
      ),
    );
  }

  String getSearchValue() {
    return _searchController.text;
  }
}
