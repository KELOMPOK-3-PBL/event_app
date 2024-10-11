import 'package:event_proposal_app/models/explore_quick_category_section.dart';
import 'package:event_proposal_app/models/explore_carousel_section.dart';
import 'package:event_proposal_app/models/search_events.dart';
import 'package:event_proposal_app/models/ui_colors.dart';
// import 'package:flutter/services.dart';

import 'package:uicons/uicons.dart';
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
        const CategoryEventsWidget(), //! memanggil model => category
        //! -- Events Available
        const CarouselSection(), //! memanggil model => carousel events
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Text(
            'Events Available',
            textAlign: TextAlign.right,
            style: TextStyle(
                color: UIColor.typoBlack,
                fontSize: 16,
                fontWeight: FontWeight.w800),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            // Wrap will automatically adjust the children horizontally and vertically
            spacing: 10,
            runSpacing: 10,
            children: List.generate(5, (index) {
              return Container(
                width: (MediaQuery.of(context).size.width - 44) /
                    2, // Adaptive width for two columns
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align contents to the start
                  children: [
                    Card(
                      color: Colors.blue[50],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/background.png',
                          height: (MediaQuery.of(context).size.width - 44) /
                              3, // Adjust image size
                          width: double.infinity,
                          alignment: Alignment.topCenter,
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
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                UIcons.regularRounded.user,
                                color: Colors.black54,
                                size: 10,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "120 Person",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                UIcons.regularRounded.location_alt,
                                color: Colors.black54,
                                size: 10,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "Semarang, Indonesia",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                UIcons.regularRounded.calendar,
                                color: Colors.black54,
                                size: 10,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "23-25 July 2023",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
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
    );
  }
}
