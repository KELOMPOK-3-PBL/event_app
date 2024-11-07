import 'package:flutter/material.dart';
import '../section/explore_event_list_section.dart';
import '../section/explore_quick_category_section.dart';
import '../section/explore_carousel_section.dart';
import '../screen/search_result_event_screen.dart';
import '../widget/search_widget.dart';

class HomeExplorePage extends StatefulWidget {
  const HomeExplorePage({super.key});

  @override
  State<HomeExplorePage> createState() => _HomeExplorePageState();
}

class _HomeExplorePageState extends State<HomeExplorePage> {
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
                          builder: (context) => SearchResultEventsScreen(
                              searchQuery: searchQuery)),
                    );
                  },
                  onPressedFilter: () {
                    // Handle the button tap action here
                    debugPrint('Tapped on FILTER ITEM-BUTTON');
                  },
                ), //! memanggil model => search
                const SizedBox(height: 4),
              ],
            ),
          ),
          const SizedBox(
            height: 14,
          ),

          const QuickCategorySection(), //! memanggil model => category
          const CarouselSection(), //! -- Carousel Events Section
          const EventListSection() //! -- Events Available Section
        ],
      ),
    );
  }
}
