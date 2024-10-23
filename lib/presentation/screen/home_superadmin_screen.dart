import 'package:event_proposal_app/presentation/navbar/bottom_navbar_superadmin.dart';
import 'package:event_proposal_app/presentation/page/home_accounts.dart';
import 'package:event_proposal_app/presentation/page/home_approval.dart';
import 'package:event_proposal_app/presentation/page/home_events.dart';
import 'package:event_proposal_app/presentation/page/home_explore.dart';
import 'package:event_proposal_app/presentation/page/home_profile.dart';
import 'package:flutter/material.dart';

class HomeSuperadmin extends StatefulWidget {
  const HomeSuperadmin({super.key});

  @override
  State<HomeSuperadmin> createState() => _HomeSuperadminState();
}

class _HomeSuperadminState extends State<HomeSuperadmin> {
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
