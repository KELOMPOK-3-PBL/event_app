import 'package:event_proposal_app/models_old/bottom_navbar.dart';
import 'package:event_proposal_app/models_old/home_accounts.dart';
import 'package:event_proposal_app/models_old/home_approval.dart';
import 'package:event_proposal_app/models_old/home_events.dart';
import 'package:event_proposal_app/models_old/home_explore.dart';
import 'package:event_proposal_app/models_old/home_profile.dart';
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
      bottomNavigationBar: BottomNavbar(
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
