import 'package:event_proposal_app/presentation/navigation/bottom_navbar_admin.dart';
import 'package:event_proposal_app/presentation/page/approval_page.dart';
import 'package:event_proposal_app/presentation/page/events_page.dart';
import 'package:event_proposal_app/presentation/page/explore_page.dart';
import 'package:event_proposal_app/presentation/page/profile_page.dart';
import 'package:flutter/material.dart';

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
    const HomeApproval(),
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
      bottomNavigationBar: BottomNavbarAdmin(
        currentIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
