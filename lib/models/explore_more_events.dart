import 'package:event_proposal_app/models/ui_colors.dart';
import 'package:intl/intl.dart';
import 'package:uicons/uicons.dart';
import 'package:flutter/material.dart';

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListWidgetState();
}

class _EventListWidgetState extends State<EventList> {
  List<EventsMore> _eventsMore = [];

  @override
  void initState() {
    super.initState();
    _eventsMore = getEventsMore();
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            children: List.generate(_eventsMore.length, (index) {
              //! COLORING STATUS BADGE
              if (_eventsMore[index].status == "Proposed") {
                statusColor = UIColor.propose;
              } else if (_eventsMore[index].status == "Pending") {
                statusColor = UIColor.pending;
              } else if (_eventsMore[index].status == "Approved") {
                statusColor = UIColor.approved;
              } else {
                statusColor = UIColor.rejected;
              }

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
                    //! Section Tittle
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
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
                    ),
                    // const SizedBox(height: 4),
                    //! Content
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const SizedBox(height: 0),
                          Container(
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 10),
                            child: Text(
                              _eventsMore[index].status,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_eventsMore[index].category} : ${_eventsMore[index].tittle}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                UIcons.regularRounded.user,
                                color: Colors.black54,
                                size: 10,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${_eventsMore[index].quota} people',
                                style: const TextStyle(
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
                              Text(
                                _eventsMore[index].location,
                                style: const TextStyle(
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
                              Text(
                                _eventsMore[index].dateStart,
                                style: const TextStyle(
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
                    const SizedBox(height: 10),
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

class EventsMore {
  String tittle;
  String category;
  String quota;
  String posterUrl;
  String place;
  String location;
  String dateStart;
  String status;

  EventsMore({
    required this.tittle,
    required this.category,
    required this.quota,
    required this.posterUrl,
    required this.place,
    required this.location,
    required this.dateStart,
    required this.status,
  });
}

List<EventsMore> getEventsMore() {
  DateTime now = DateTime.now();
  List<EventsMore> events = [];

  events.add(EventsMore(
    tittle: 'Techcom Fest 2027',
    category: 'Competition',
    quota: '12',
    posterUrl: "http://192.168.110.131/poster/IMG-20231209-WA0006.jpg",
    place: "GKT II",
    location: "Semarang, Indonesia",
    dateStart: DateFormat('E, d MMM yyy').format(now),
    status: "Proposed",
  ));
  events.add(EventsMore(
    tittle: 'AI For Technology ',
    category: 'Seminar',
    quota: '120',
    posterUrl: "http://192.168.110.131/poster/IMG-20240131-WA0001.jpg",
    place: "GKT I",
    location: "Semarang, Indonesia",
    dateStart: DateFormat('E, d MMM yyy').format(now),
    status: "Pending",
  ));
  events.add(EventsMore(
    tittle: 'Electro Fest',
    category: 'Expo',
    quota: '100',
    posterUrl: "http://192.168.110.131/poster/IMG-20231209-WA0006.jpg",
    place: "GKT I",
    location: "Semarang, Indonesia",
    dateStart: DateFormat('E, d MMM yyy').format(now),
    status: "Rejected",
  ));
  return events;
}
