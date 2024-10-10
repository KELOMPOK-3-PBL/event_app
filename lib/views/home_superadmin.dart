import 'package:event_proposal_app/models/category_events.dart';
import 'package:event_proposal_app/models/carousel_events.dart';
import 'package:event_proposal_app/models/bottom_navbar.dart';
import 'package:event_proposal_app/models/search_events.dart';
import 'package:event_proposal_app/models/ui_colors.dart';
// import 'package:flutter/services.dart';

import 'package:uicons/uicons.dart';
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

            //! -- Quick Category
            CategoryEvents.getCategoryEvents(), //! memanggil model => category
            //! -- Newly Proposed Events
            CarouselEvents.getCarouselEvents(),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Text(
                'Events Available',
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: UIColor.typoBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w800),
              ),
            ),
            //! -- Another Events
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                // Wrap will automatically adjust the children horizontally and vertically
                spacing: 10,
                runSpacing: 10,
                children: List.generate(4, (index) {
                  return Container(
                    width: (MediaQuery.of(context).size.width - 44) /
                        2, // Adaptive width for two columns
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Align contents to the start
                      children: [
                        Card(
                          color: Colors.blue[50],
                          // elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              'http://192.168.110.131/poster/IMG-20231209-WA0006.jpg',
                              height: 100, // Adjust image size
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // const SizedBox(height: 0),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue[300],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                child: const Text(
                                  'Proposed',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                "Competition : Business Plan",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.people,
                                    color: Colors.black54,
                                    size: 14,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "120 Person",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.black54,
                                    size: 14,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Semarang, Indonesia",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.black54,
                                    size: 14,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "23-25 July 2023",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 14,
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
