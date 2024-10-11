import 'package:flutter/material.dart';
import 'package:event_proposal_app/models/ui_colors.dart';

import 'package:uicons/uicons.dart';
import 'package:intl/intl.dart';

class CarouselSection extends StatefulWidget {
  const CarouselSection({super.key});

  @override
  State<CarouselSection> createState() => _CarouselEventsState();
}

class _CarouselEventsState extends State<CarouselSection> {
  List<CarouselEventsModel> _eventsCarousel = [];

  @override
  void initState() {
    super.initState();
    _eventsCarousel = getEventsCarousel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //! Section Tittle
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: Text(
            'Newly Proposed Events',
            textAlign: TextAlign.right,
            style: TextStyle(
                color: UIColor.typoBlack,
                fontSize: 16,
                fontWeight: FontWeight.w800),
          ),
        ),
        //! Carousel Content
        SizedBox(
          height: (MediaQuery.of(context).size.width - 40) / 1.66,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: _eventsCarousel.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
            separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        // image: AssetImage('assets/image_welcome.png'),
                        image: NetworkImage(_eventsCarousel[index].posterUrl),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          // color: events[index].boxColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Card(
                        // shadowColor: UIColor.bgCarousel,
                        color: UIColor.bgCarousel,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          // width: 300,
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    color: UIColor.typoBlack,
                                    UIcons.regularRounded.user,
                                    size: 12,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text("${_eventsCarousel[index].quota} people",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: UIColor.typoBlack,
                                      ))
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    color: UIColor.typoBlack,
                                    UIcons.regularRounded.house_flood,
                                    size: 12,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(_eventsCarousel[index].place,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: UIColor.typoBlack,
                                      ))
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    color: UIColor.typoBlack,
                                    UIcons.regularRounded.location_alt,
                                    size: 12,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(_eventsCarousel[index].location,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: UIColor.typoBlack,
                                      ))
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    color: UIColor.typoBlack,
                                    UIcons.regularRounded.calendar,
                                    size: 12,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(_eventsCarousel[index].dateStart,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: UIColor.typoBlack,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CarouselEventsModel {
  String tittle;
  String quota;
  String posterUrl;
  String place;
  String location;
  String dateStart;
  String status;

  CarouselEventsModel({
    required this.tittle,
    required this.quota,
    required this.posterUrl,
    required this.place,
    required this.location,
    required this.dateStart,
    required this.status,
  });
}

List<CarouselEventsModel> getEventsCarousel() {
  DateTime now = DateTime.now();
  List<CarouselEventsModel> events = [];

  events.add(CarouselEventsModel(
    tittle: 'Proposed',
    quota: '12',
    posterUrl: "http://192.168.110.131/poster/IMG-20231209-WA0006.jpg",
    place: "GKT II",
    location: "Semarang, Indonesia",
    dateStart: DateFormat('E, d MMM yyy').format(now),
    status: "Propose",
  ));
  events.add(CarouselEventsModel(
    tittle: 'Proposed',
    quota: '120',
    posterUrl: "http://192.168.110.131/poster/IMG-20240131-WA0001.jpg",
    place: "GKT I",
    location: "Semarang, Indonesia",
    dateStart: DateFormat('E, d MMM yyy').format(now),
    status: "Approved",
  ));
  events.add(CarouselEventsModel(
    tittle: 'Proposed',
    quota: '20',
    posterUrl: "http://192.168.110.131/poster/IMG-20231209-WA0006.jpg",
    place: "GKT I",
    location: "Semarang, Indonesia",
    dateStart: DateFormat('E, d MMM yyy').format(now),
    status: "Approved",
  ));
  return events;
}
