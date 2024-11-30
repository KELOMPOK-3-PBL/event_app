import 'package:event_proposal_app/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:uicons_pro/uicons_pro.dart';

import '../section/detail_profile_section/card_info.dart';
import '../theme/ui_colors.dart';

class EventCard extends StatelessWidget {
  final EventDataModel events;

  const EventCard({
    super.key,
    required this.events,
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
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    // Menampilkan gambar error jika gambar gagal dimuat
                    return Image.asset(
                      'assets/images/image_not_found.png',
                      height: (MediaQuery.of(context).size.width / 3),
                      width: (MediaQuery.of(context).size.width / 4),
                      fit: BoxFit.cover,
                    );
                  },
                )),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 8, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${events.category}: ${events.title}',
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
