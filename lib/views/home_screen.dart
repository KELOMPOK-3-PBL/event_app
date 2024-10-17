import 'package:event_proposal_app/models/bottom_navbar.dart';
import 'package:event_proposal_app/models/home_approval.dart';
import 'package:event_proposal_app/models/home_events.dart';
import 'package:event_proposal_app/models/home_explore.dart';
import 'package:event_proposal_app/models/search_events.dart';
import 'package:event_proposal_app/models/ui_colors.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const HomeExplore(),
    const HomeEvents(),
    const HomeApproval(),
    Scaffold(
      body: Container(), // Add your accounts screen widget here
    ),
    Scaffold(
      body: Container(), // Add your profile screen widget here
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (_currentIndex != 0)
            AppBar(
              automaticallyImplyLeading:
                  false, // remove leading(left) back icon
              centerTitle: true,
              backgroundColor: UIColor.solidWhite,
              scrolledUnderElevation: 0,
              title: Text(
                _getTitle(_currentIndex),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: UIColor.typoBlack,
                ),
              ),
            ),
          Expanded(
            child: _widgetOptions.elementAt(_currentIndex),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        onItemSelected: _onItemTapped,
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 1:
        return "Events";
      case 2:
        return "Approval";
      case 3:
        return "Accounts";
      case 4:
        return "My Profile";
      default:
        return "";
    }
  }
}
