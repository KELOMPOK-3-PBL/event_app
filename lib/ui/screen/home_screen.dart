import 'package:flutter/material.dart';

import '../navigation/bottom_navbar_superadmin.dart';
import '../page/accounts_page.dart';
import '../page/approval_page.dart';
import '../page/events_page.dart';
import '../page/explore_page.dart';
import '../page/profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const HomeExplore(),
    const HomeEvents(),
    const HomeApproval(),
    const HomeAccounts(),
    const HomeProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavbarSuperadmin(
        currentIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
