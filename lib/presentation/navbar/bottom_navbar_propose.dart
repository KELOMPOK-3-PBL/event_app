import 'package:event_proposal_app/presentation/navbar/custom_navbar_item.dart';
import 'package:event_proposal_app/presentation/widget/ui_colors.dart';

import 'package:uicons_pro/uicons_pro.dart';
import 'package:flutter/material.dart';

class BottomNavbarPropose extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  const BottomNavbarPropose({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: const BoxDecoration(
          color: UIColor.solidWhite,
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 13,
          unselectedFontSize: 13,
          selectedItemColor: UIColor.primary,
          unselectedItemColor: UIColor.typoGray2,
          showUnselectedLabels: true,
          currentIndex: currentIndex,
          onTap: onItemTapped,
          items: <BottomNavigationBarItem>[
            customNavbarItem(UIconsPro.solidRounded.navigation, 'Explore'),
            customNavbarItem(UIconsPro.solidRounded.calendar, 'Events'),
            customNavbarItem(UIconsPro.solidRounded.database, 'Propose'),
            customNavbarItem(UIconsPro.solidRounded.user, 'Profile'),
          ],
        ));
  }
}