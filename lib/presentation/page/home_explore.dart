import 'package:event_proposal_app/presentation/page/section/explore_event_list_section.dart';
import 'package:event_proposal_app/presentation/page/section/explore_quick_category_section.dart';
import 'package:event_proposal_app/presentation/page/section/explore_carousel_section.dart';
import 'package:event_proposal_app/presentation/screen/search_result_event_screen.dart';
// import 'package:event_proposal_app/presentation/widget/search_events.dart';
import 'package:event_proposal_app/presentation/widget/search_widget.dart';
// import 'package:event_proposal_app/models/ui_colors.dart';
// import 'package:event_proposal_app/models/ui_colors.dart';
// import 'package:flutter/services.dart';

// import 'package:uicons_pro/uicons_pro.dart';
import 'package:flutter/material.dart';

class HomeExplore extends StatefulWidget {
  const HomeExplore({super.key});

  @override
  State<HomeExplore> createState() => _HomeExploreState();
}

class _HomeExploreState extends State<HomeExplore> {
  // final GlobalKey<SearchEventsWidgetState> _searchKey =
  //     GlobalKey<SearchEventsWidgetState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/background.png'),
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
                SearchWidget(
                  label: 'Search Event ...',
                  onSubmittedKeyboard: (searchQuery) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchEventsResultScreen(
                              searchQuery: searchQuery)),
                    );
                  },
                  onPressedFilter: () {
                    // Handle the button tap action here
                    print('Tapped on FILTER ITEM-BUTTON');
                  },
                ), //! memanggil model => search
                const SizedBox(height: 4),
              ],
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          const QuickCategorySection(), //! -- Quick Category
          const CarouselSection(), //! -- Carousel Events
          const EventListSection() //! -- Events Available
        ],
      ),
    );
  }
}
