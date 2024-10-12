// import 'package:event_proposal_app/models/category_events.dart';
// import 'package:event_proposal_app/models/carousel_events.dart';
import 'package:event_proposal_app/models/bottom_navbar.dart';
// import 'package:event_proposal_app/models/search_events.dart';
// import 'package:event_proposal_app/models/ui_colors.dart';
import 'package:event_proposal_app/models/home_explore.dart';

// import 'package:flutter/services.dart';
// import 'package:uicons_pro/uicons_pro.dart';
import 'package:flutter/material.dart';

class HomeSuperadmin extends StatefulWidget {
  const HomeSuperadmin({super.key});

  @override
  State<HomeSuperadmin> createState() => _HomeSuperadminState();
}

TextStyle optionStyle =
    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

class _HomeSuperadminState extends State<HomeSuperadmin> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    //! List 0
    const HomeExplore(),
    //! List 1
    Center(
      child: Text(
        'Index 1: Events',
        style: optionStyle,
      ),
    ),
    //! List 2
    Center(
      child: Text(
        'Index 2: Approval',
        style: optionStyle,
      ),
    ),
    //! List 3
    Center(
      child: Text(
        'Index 3: Accounts',
        style: optionStyle,
      ),
    ),
    //! List 4
    Center(
      child: Text(
        'Index 4: Profile',
        style: optionStyle,
      ),
    ), // Add this
    // Add other widgets for other bottom navigation bar items
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // CategoryModel.getCategories();
    return Scaffold(
      appBar: _selectedIndex == 0 ? null : AppBar(),
      body: _widgetOptions.elementAt(_selectedIndex), // Change this
      bottomNavigationBar: BottomNavbar(
        onItemSelected: _onItemTapped, // Change this
      ),
    );
  }
}
