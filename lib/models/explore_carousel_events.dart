import 'package:flutter/material.dart';
import 'package:event_proposal_app/models/ui_colors.dart';

import 'package:uicons/uicons.dart';
import 'package:intl/intl.dart';

class CarouselEvents {
  String tittle;
  String quota;
  String posterUrl;
  String place;
  String location;
  String dateStart;
  String status;

  CarouselEvents({
    required this.tittle,
    required this.quota,
    required this.posterUrl,
    required this.place,
    required this.location,
    required this.dateStart,
    required this.status,
  });

  //! Isi Category -- nama & warna --
  static List<CarouselEvents> getEvents() {
    DateTime now = DateTime.now();
    List<CarouselEvents> events = [];

    events.add(CarouselEvents(
      tittle: 'Proposed',
      quota: '12',
      posterUrl: "http://172.16.172.122/poster/IMG-20231209-WA0006.jpg",
      place: "GKT II",
      location: "Semarang, Indonesia",
      dateStart: DateFormat('E, d MMM yyy').format(now),
      status: "",
    ));
    events.add(CarouselEvents(
      tittle: 'Proposed',
      quota: '120',
      posterUrl: "http://172.16.172.122/poster/IMG-20240131-WA0001.jpg",
      place: "",
      location: "",
      dateStart: DateFormat('E, d MMM yyy').format(now),
      status: "",
    ));
    events.add(CarouselEvents(
      tittle: 'Proposed',
      quota: '20',
      posterUrl: "http://172.16.172.122/poster/IMG-20231209-WA0006.jpg",
      place: "",
      location: "",
      dateStart: DateFormat('E, d MMM yyy').format(now),
      status: "",
    ));
    return events;
  }

  //! model tampilan
  static getCarouselEvents() {
    List<CarouselEvents> events = [];
    events = CarouselEvents.getEvents();

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
      SizedBox(
        height: 200,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: events
              .length, // memanggil events sesuai dengan jumlah yg ada di models
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 20, right: 20),
          // membuat jarak diantara widget
          separatorBuilder: (context, index) => const SizedBox(
            width: 10,
          ),
          itemBuilder: (context, index) {
            return Container(
              // height: 50,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(events[index].posterUrl),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter),
                  // color: events[index].boxColor,
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
                                Text("${events[index].quota} people",
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
                                Text(events[index].place,
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
                                Text(events[index].location,
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
                                Text(events[index].dateStart,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: UIColor.typoBlack,
                                    ))
                              ],
                            ),
                            // const Row(
                            //   children: [
                            //     Icon(Icons.location_on),
                            //     Text('Semarang, Indonesia'),
                            //   ],
                            // ),
                            // const Row(
                            //   children: [
                            //     Icon(Icons.calendar_month),
                            //     Text('23 - 25 July 2024'),
                            //   ],
                            // ),
                            // const Row(
                            //   children: [
                            //     Icon(Icons.shopping_cart),
                            //     Text('GKT Lt. 2'),
                            //   ],
                            // ),
                            // const SizedBox(height: 20),
                            // ElevatedButton(
                            //   onPressed: () {},
                            //   child: const Text('Proposed'),
                            // ),
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
    ]);
  }
}
