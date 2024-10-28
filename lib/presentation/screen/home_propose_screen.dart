import 'package:flutter/material.dart';

import '../navigation/bottom_navbar_propose.dart';
import '../page/events_page.dart';
import '../page/explore_page.dart';
import '../page/profile_page.dart';
import '../page/propose_page.dart';

class HomeSuperadminScreen extends StatefulWidget {
  const HomeSuperadminScreen({
    super.key,
  });

  @override
  State<HomeSuperadminScreen> createState() => _HomeSuperadminScreenState();
}

class _HomeSuperadminScreenState extends State<HomeSuperadminScreen> {
  int _currentIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const HomeExplore(),
    const HomeEvents(),
    const HomePropose(),
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
      bottomNavigationBar: BottomNavbarPropose(
        currentIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
