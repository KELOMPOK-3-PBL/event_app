import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../navigation/bottom_navbar_superadmin.dart';

class HomeScreen extends StatefulWidget {
  final Widget? child;
  const HomeScreen({
    super.key,
    this.child,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  // }

  void changeTab(int index) {
    switch (index) {
      case 0:
        context.goNamed('explore');
        break;
      case 1:
        context.goNamed('events');
        break;
      case 2:
        context.goNamed('approval');
        break;
      case 3:
        context.goNamed('accounts');
        break;
      case 4:
        context.goNamed('profile');
        break;
      default:
        context.goNamed('explore');
        break;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final List<Widget> widgetOptions = <Widget>[
    //   const HomeExplorePage(),
    //   const HomeEventsPage(),
    //   const HomeApprovalPage(),
    //   const HomeAccountsPage(),
    //   const HomeProfilePage(),
    // ];

    return Scaffold(
      // body: widgetOptions.elementAt(_currentIndex),
      body: widget.child,
      bottomNavigationBar: BottomNavbarSuperadmin(
        currentIndex: _currentIndex,
        // onItemTapped: _onItemTapped,
        onItemTapped: changeTab,
      ),
    );
  }
}
