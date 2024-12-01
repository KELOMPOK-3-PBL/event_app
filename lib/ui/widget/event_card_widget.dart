import 'package:event_proposal_app/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:uicons_pro/uicons_pro.dart';

import '../section/detail_event_section/card_info.dart';
import '../theme/ui_colors.dart';

class EventCardWidget extends StatelessWidget {
  final EventDataModel events;
  final String currentRole;
  final bool showStatus;

  const EventCardWidget({
    super.key,
    required this.events,
    required this.currentRole,
    required this.showStatus,
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
          Column(
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
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 8, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if (showStatus == false)
                  //   Container(
                  //     margin: EdgeInsets.only(bottom: 4),
                  //     // width: 108,
                  //     // height: 20,
                  //     decoration: BoxDecoration(
                  //         color: UIColor.reviewing,
                  //         borderRadius: BorderRadius.circular(8)),
                  //     child: Container(
                  //       margin: EdgeInsets.symmetric(
                  //           horizontal:
                  //               (MediaQuery.of(context).size.width / 20),
                  //           vertical: 3),
                  //       child: Text(
                  //         'See detail',
                  //         textAlign: TextAlign.center,
                  //         style: const TextStyle(
                  //             color: UIColor.solidWhite,
                  //             // height: 2.5,
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 12),
                  //       ),
                  //     ),
                  //   ),
                  if (showStatus)
                    Container(
                      decoration: BoxDecoration(
                        color: UIColor.getStatusColor(events.status),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 12),
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
