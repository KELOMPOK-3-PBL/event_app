import 'package:event_proposal_app/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:uicons_pro/uicons_pro.dart';

import './card_info_row.dart';
import './ui_colors.dart';

class EventCardWithStatusWidget extends StatelessWidget {
  final EventModel events;
  // final String tittle;
  // final String category;
  // final String quota;
  // final String posterUrl;
  // final String place;
  // final String location;
  // final String dateStart;
  // final String status;

  const EventCardWithStatusWidget({
    super.key,
    required this.events,
    // required this.tittle,
    // required this.category,
    // required this.quota,
    // required this.posterUrl,
    // required this.place,
    // required this.location,
    // required this.dateStart,
    // required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: UIColor.solidWhite,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Image.network(
                events.posterUrl.toString(),
                // height: 120,
                // width: 90,
                height: (MediaQuery.of(context).size.width / 3),
                width: (MediaQuery.of(context).size.width / 4),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 8, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: UIColor.getStatusColor(events.status),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    child: Text(
                      events.status,
                      style: const TextStyle(
                        color: UIColor.solidWhite,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  // const SizedBox(height: 8),
                  Text(
                    '${events.category}: ${events.tittle}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: UIColor.typoBlack,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  cardInfoRow(UIconsPro.regularRounded.user_time,
                      '${events.quota} participants'),
                  cardInfoRow(
                      UIconsPro.regularRounded.house_building, events.place),
                  cardInfoRow(
                      UIconsPro.regularRounded.marker, events.location ?? ''),
                  cardInfoRow(
                      UIconsPro.regularRounded.calendar, events.dateStart),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
