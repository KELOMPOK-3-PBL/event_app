import 'package:event_proposal_app/models/category_events.dart';
import 'package:event_proposal_app/models/carousel_events.dart';
import 'package:event_proposal_app/models/bottom_navbar.dart';
import 'package:event_proposal_app/models/search_events.dart';
import 'package:event_proposal_app/models/ui_colors.dart';
// import 'package:flutter/services.dart';

// import 'package:uicons/uicons.dart';
import 'package:flutter/material.dart';

class HomeSuperadmin extends StatefulWidget {
  const HomeSuperadmin({super.key});

  @override
  State<HomeSuperadmin> createState() => _HomeSuperadminState();
}

class _HomeSuperadminState extends State<HomeSuperadmin> {
  @override
  void initState() {
    super.initState();
    // CategoryModel.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    // CategoryModel.getCategories();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/background.png'),
                  fit: BoxFit
                      .cover, // Set the image to cover the entire container
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
                  const Text(
                    'Hi, Fattur 👋',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'You are logged in as superadmin',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 63),
                  SearchEvents.searchEvents(), //! memanggil model => search
                  const SizedBox(height: 4),
                ],
              ),
            ),
            const SizedBox(
              height: 14,
            ),

            //! -- quick category
            CategoryEvents.getCategoryEvents(), //! memanggil model => category
            //! -- Newly Proposed Events
            CarouselEvents.getCarouselEvents(),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                  child: Text(
                    'Events Available',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: UIColor.typoBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                // SizedBox(
                //   height: 200,
                //   child: ListView.builder(itemBuilder: (context, index) {
                //     return Container();
                //   }),
                // ),
              ],
            ),
          ],
        ),
      ),

      //! BOTTOM NAVBAR
      bottomNavigationBar:
          BottomNavbar.navBarSuperadmin(), //! memanggil model => bottom navbar
    );
  }
}
