import 'package:event_proposal_app/uikit/ui_colors.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uicons/uicons.dart';
import 'package:flutter/material.dart';

void initState() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness:
        Brightness.light, // Menetapkan warna ikon status bar
  ));
}

class HomeSuperadmin extends StatelessWidget {
  const HomeSuperadmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/head_darken.png'),
                fit:
                    BoxFit.cover, // Set the image to cover the entire container
              ),
              border: Border.all(
                color: Colors.blue, // Set the border color to white
                width: 0, // Set the border width to 1
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Hi, Fattur 👋',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'You are logged in as superadmin',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 63),
                SizedBox(
                  height: 45,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search event..',
                      hintStyle: const TextStyle(
                          color: UIColor.typoGray, height: 1.5, fontSize: 14),
                      prefixIcon: Icon(
                        UIcons.regularRounded.search,
                        color: UIColor.typoBlack,
                        size: 18,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
      // body: Container(
      //   padding: const EdgeInsets.all(16),
      //   child: Column(
      //     children: [
      //       Row(
      //         children: [
      //           Expanded(
      //             child: ElevatedButton(
      //               onPressed: () {},
      //               style: ElevatedButton.styleFrom(
      //                 backgroundColor: Colors.blue,
      //                 padding: const EdgeInsets.symmetric(vertical: 16),
      //                 shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(8),
      //                 ),
      //               ),
      //               child: const Text('Proposed'),
      //             ),
      //           ),
      //           const SizedBox(width: 16),
      //           Expanded(
      //             child: ElevatedButton(
      //               onPressed: () {},
      //               style: ElevatedButton.styleFrom(
      //                 backgroundColor: Colors.orange,
      //                 padding: const EdgeInsets.symmetric(vertical: 16),
      //                 shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(8),
      //                 ),
      //               ),
      //               child: const Text('Pending'),
      //             ),
      //           ),
      //         ],
      //       ),
      //       const SizedBox(height: 16),
      //       Row(
      //         children: [
      //           Expanded(
      //             child: ElevatedButton(
      //               onPressed: () {},
      //               style: ElevatedButton.styleFrom(
      //                 backgroundColor: Colors.red,
      //                 padding: const EdgeInsets.symmetric(vertical: 16),
      //                 shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(8),
      //                 ),
      //               ),
      //               child: const Text('Rejected'),
      //             ),
      //           ),
      //           const SizedBox(width: 16),
      //           Expanded(
      //             child: ElevatedButton(
      //               onPressed: () {},
      //               style: ElevatedButton.styleFrom(
      //                 backgroundColor: Colors.green,
      //                 padding: const EdgeInsets.symmetric(vertical: 16),
      //                 shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(8),
      //                 ),
      //               ),
      //               child: const Text('Approved'),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
      bottomNavigationBar: Container(
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
          currentIndex: 0,
          selectedFontSize: 13,
          unselectedFontSize: 13,
          selectedItemColor: UIColor.primary, // Set warna item selected
          unselectedItemColor:
              UIColor.typoGray2, // Set warna item tidak selected
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
        ),
      ),
    );
  }
}
