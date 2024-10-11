// import 'package:event_proposal_app/models/category_events.dart';
// import 'package:event_proposal_app/models/carousel_events.dart';
import 'package:event_proposal_app/models/bottom_navbar.dart';
// import 'package:event_proposal_app/models/search_events.dart';
// import 'package:event_proposal_app/models/ui_colors.dart';
import 'package:event_proposal_app/models/home_explore.dart';

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
      body: const SingleChildScrollView(
        child: Column(
          children: [
            EventSection(), // Use the EventSection widget here
          ],
        ),
      ),

      //! BOTTOM NAVBAR
      bottomNavigationBar:
          BottomNavbar.navBarSuperadmin(), //! memanggil model => bottom navbar
    );
  }
}
