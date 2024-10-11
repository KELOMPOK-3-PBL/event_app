import 'package:event_proposal_app/models/explore_more_events.dart';
import 'package:event_proposal_app/models/explore_quick_category_section.dart';
import 'package:event_proposal_app/models/explore_carousel_section.dart';
import 'package:event_proposal_app/models/search_events.dart';
// import 'package:event_proposal_app/models/ui_colors.dart';
// import 'package:flutter/services.dart';

// import 'package:uicons/uicons.dart';
import 'package:flutter/material.dart';

class EventSection extends StatefulWidget {
  const EventSection({super.key});

  @override
  State<EventSection> createState() => _EventSectionState();
}

class _EventSectionState extends State<EventSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover, // Set the image to cover the entire container
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
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                'Hi, Fattur 👋',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'You are logged in as superadmin',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 63),
              SearchEventsWidget(), //! memanggil model => search
              SizedBox(height: 4),
            ],
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        const QuickCategorySection(), //! -- Quick Category
        const CarouselSection(), //! -- Carousel Events
        const EventList() //! -- Events Available
      ],
    );
  }
}
