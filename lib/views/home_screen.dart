import 'package:event_proposal_app/models/bottom_navbar.dart';
import 'package:event_proposal_app/models/home_events.dart';
import 'package:event_proposal_app/models/home_explore.dart';
import 'package:event_proposal_app/models/ui_colors.dart';
import 'package:flutter/material.dart';

class HomeSuperadmin extends StatefulWidget {
  const HomeSuperadmin({super.key});

  @override
  State<HomeSuperadmin> createState() => _HomeSuperadminState();
}

TextStyle optionStyle = const TextStyle(
    fontSize: 20, fontWeight: FontWeight.bold, color: UIColor.typoBlack);

class _HomeSuperadminState extends State<HomeSuperadmin> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    //! List 0
    const HomeExplore(),
    //! List 1
    Scaffold(
      appBar: AppBar(
        title: Text(
          "Events",
          style: optionStyle,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: UIColor.solidWhite,
        // foregroundColor: UIColor.solidWhite,
        centerTitle: true,
      ),
      body: const HomeEvents(),
    ),
    //! List 2
    Scaffold(
      appBar: AppBar(
        title: Text(
          "Approval",
          style: optionStyle,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: UIColor.solidWhite,
        centerTitle: true,
      ),
      // body:
    ),
    //! List 3
    Scaffold(
      appBar: AppBar(
        title: Text(
          "Accounts",
          style: optionStyle,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: UIColor.solidWhite,
        centerTitle: true,
      ),
      // body:
    ),
    //! List 4
    Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: optionStyle),
        automaticallyImplyLeading: false,
        backgroundColor: UIColor.solidWhite,
        centerTitle: true,
      ),
      // body:
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavbar(
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
