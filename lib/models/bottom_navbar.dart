import 'package:event_proposal_app/models/ui_colors.dart';
import 'package:uicons/uicons.dart';
import 'package:flutter/material.dart';

class BottomNavbar {
  //! SUPERADMIN
  static Container navBarSuperadmin() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
          10, 10, 10, 0), // Tambahkan padding untuk bagian atas
      decoration: const BoxDecoration(
        color: UIColor.bgSolidWhite, // Set warna background
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ), // Tambahkan radius untuk bagian atas
      ),
      child: BottomNavigationBar(
        elevation: 0, // Hilangkan shadow
        backgroundColor:
            Colors.transparent, // Set warna background menjadi transparan
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        selectedItemColor: UIColor.primary, // Set warna item selected
        unselectedItemColor: UIColor.typoGray2, // Set warna item tidak selected
        // selectedIconTheme:
        //     const IconThemeData(size: 28), // Set ukuran icon selected
        // unselectedIconTheme:
        //     const IconThemeData(size: 28), // Set ukuran icon tidak selected
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(UIcons.solidRounded.navigation),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(UIcons.solidRounded.calendar),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(UIcons.solidRounded.cloud_check),
            label: 'Approval',
          ),
          BottomNavigationBarItem(
            icon: Icon(UIcons.solidRounded.users_alt),
            label: 'Accounts',
          ),
          BottomNavigationBarItem(
            icon: Icon(UIcons.solidRounded.user),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
      ),
    );
  }
}
