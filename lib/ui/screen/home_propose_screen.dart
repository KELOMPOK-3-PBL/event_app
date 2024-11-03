import 'package:flutter/material.dart';

import '../navigation/bottom_navbar_propose.dart';
import '../page/events_page.dart';
import '../page/explore_page.dart';
import '../page/profile_page.dart';
import '../page/propose_page.dart';

class HomeProposeScreen extends StatefulWidget {
  const HomeProposeScreen({
    super.key,
  });

  @override
  State<HomeProposeScreen> createState() => _HomeProposeScreenState();
}

class _HomeProposeScreenState extends State<HomeProposeScreen> {
  int _currentIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const HomeExplorePage(),
    const HomeEventsPage(),
    const HomeProposePage(),
    const HomeProfilePage(),
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
