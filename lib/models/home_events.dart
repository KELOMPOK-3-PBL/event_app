import 'package:event_proposal_app/models/search_events.dart';
import 'package:event_proposal_app/models/ui_colors.dart';
import 'package:intl/intl.dart';
import 'package:uicons_pro/uicons_pro.dart';
import 'package:flutter/material.dart';

class HomeEvents extends StatefulWidget {
  const HomeEvents({super.key});

  @override
  State<HomeEvents> createState() => _HomeEventsState();
}

class _HomeEventsState extends State<HomeEvents> {
  late List<Events> _events;

  @override
  void initState() {
    super.initState();
    _events = getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: SearchEventsWidget(),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _events.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: _buildEventCard(_events[index]),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Events event) {
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
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Image.network(
                event.posterUrl,
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${event.category}: ${event.tittle}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: UIColor.typoBlack,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  _buildInfoRow(UIconsPro.regularRounded.user_time,
                      '${event.quota} participants'),
                  _buildInfoRow(
                      UIconsPro.regularRounded.house_building, event.place),
                  _buildInfoRow(
                      UIconsPro.regularRounded.marker, event.location),
                  _buildInfoRow(
                      UIconsPro.regularRounded.calendar, event.dateStart),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Icon(icon, color: UIColor.typoGray, size: 10),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: UIColor.typoBlack,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class Events {
  String tittle;
  String category;
  String quota;
  String posterUrl;
  String place;
  String location;
  String dateStart;
  String status;

  Events({
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

List<Events> getEvents() {
  DateTime now = DateTime.now();
  List<Events> events = [];

  events.add(Events(
    tittle: 'Techcom Fest 2027',
    category: 'Competition',
    quota: '12',
    posterUrl: "http://192.168.110.131/poster/IMG-20231209-WA0006.jpg",
    place: "GKT II",
    location: "Semarang, Indonesia",
    dateStart: DateFormat('E, d MMM yyy').format(now),
    status: "Proposed",
  ));
  events.add(Events(
    tittle: 'AI For Technology ',
    category: 'Seminar',
    quota: '120',
    posterUrl: "http://192.168.110.131/poster/IMG-20240131-WA0001.jpg",
    place: "GKT I",
    location: "Semarang, Indonesia",
    dateStart: DateFormat('E, d MMM yyy').format(now),
    status: "Pending",
  ));
  events.add(Events(
    tittle: 'Electro Fest',
    category: 'Expo',
    quota: '100',
    posterUrl: "http://192.168.110.131/poster/IMG-20240210-WA0014.jpg",
    place: "GKT I",
    location: "Semarang, Indonesia",
    dateStart: DateFormat('E, d MMM yyy').format(now),
    status: "Rejected",
  ));
  events.add(Events(
    tittle: 'Electro Fest',
    category: 'Expo',
    quota: '100',
    posterUrl: "http://192.168.110.131/poster/IMG-20240210-WA0014.jpg",
    place: "GKT I",
    location: "Semarang, Indonesia",
    dateStart: DateFormat('E, d MMM yyy').format(now),
    status: "Rejected",
  ));
  events.add(Events(
    tittle: 'Electro Fest',
    category: 'Expo',
    quota: '100',
    posterUrl: "http://192.168.110.131/poster/IMG-20240210-WA0014.jpg",
    place: "GKT I",
    location: "Semarang, Indonesia",
    dateStart: DateFormat('E, d MMM yyy').format(now),
    status: "Rejected",
  ));
  events.add(Events(
    tittle: 'Electro Fest',
    category: 'Expo',
    quota: '100',
    posterUrl: "http://192.168.110.131/poster/IMG-20240210-WA0014.jpg",
    place: "GKT I",
    location: "Semarang, Indonesia",
    dateStart: DateFormat('E, d MMM yyy').format(now),
    status: "Rejected",
  ));
  events.add(Events(
    tittle: 'Electro Fest',
    category: 'Expo',
    quota: '100',
    posterUrl: "http://192.168.110.131/poster/IMG-20240210-WA0014.jpg",
    place: "GKT I",
    location: "Semarang, Indonesia",
    dateStart: DateFormat('E, d MMM yyy').format(now),
    status: "Rejected",
  ));
  events.add(Events(
    tittle: 'Electro Fest',
    category: 'Expo',
    quota: '100',
    posterUrl: "http://192.168.110.131/poster/IMG-20240210-WA0014.jpg",
    place: "GKT I",
    location: "Semarang, Indonesia",
    dateStart: DateFormat('E, d MMM yyy').format(now),
    status: "Rejected",
  ));
  events.add(Events(
    tittle: 'Electro Fest',
    category: 'Expo',
    quota: '100',
    posterUrl: "http://192.168.110.131/poster/IMG-20240210-WA0014.jpg",
    place: "GKT I",
    location: "Semarang, Indonesia",
    dateStart: DateFormat('E, d MMM yyy').format(now),
    status: "Rejected",
  ));
  events.add(Events(
    tittle: 'Electro Fest',
    category: 'Expo',
    quota: '100',
    posterUrl: "http://192.168.110.131/poster/IMG-20240210-WA0014.jpg",
    place: "GKT I",
    location: "Semarang, Indonesia",
    dateStart: DateFormat('E, d MMM yyy').format(now),
    status: "Rejected",
  ));
  events.add(Events(
    tittle: 'Electro Fest',
    category: 'Expo',
    quota: '100',
    posterUrl: "http://192.168.110.131/poster/IMG-20240210-WA0014.jpg",
    place: "GKT I",
    location: "Semarang, Indonesia",
    dateStart: DateFormat('E, d MMM yyy').format(now),
    status: "Rejected",
  ));

  events.add(Events(
    tittle: 'Electro Fest',
    category: 'Expo',
    quota: '100',
    posterUrl: "http://192.168.110.131/poster/IMG-20240210-WA0014.jpg",
    place: "GKT I",
    location: "Semarang, Indonesia",
    dateStart: DateFormat('E, d MMM yyy').format(now),
    status: "Rejected",
  ));
  events.add(Events(
    tittle: 'Electro Fest',
    category: 'Expo',
    quota: '100',
    posterUrl: "http://192.168.110.131/poster/IMG-20240210-WA0014.jpg",
    place: "GKT I",
    location: "Semarang, Indonesia",
    dateStart: DateFormat('E, d MMM yyy').format(now),
    status: "Rejected",
  ));
  return events;
}
