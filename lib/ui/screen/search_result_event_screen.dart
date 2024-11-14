import 'package:flutter/material.dart';
import 'package:uicons_pro/uicons_pro.dart';

import '../theme/ui_colors.dart';

class SearchResultEventsScreen extends StatelessWidget {
  final String searchQuery;

  const SearchResultEventsScreen({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(UIconsPro.regularRounded.angle_small_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: true, // remove leading(left) back icon
        centerTitle: true,
        backgroundColor: UIColor.solidWhite,
        scrolledUnderElevation: 0,
        title: Text(
          "Search Result",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: UIColor.typoBlack,
          ),
        ),
      ),
      body: Center(
        child: Text('Search results for: $searchQuery'),
      ),
    );
  }
}
