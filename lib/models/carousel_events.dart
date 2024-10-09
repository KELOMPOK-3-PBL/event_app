import 'package:flutter/material.dart';
import 'package:event_proposal_app/models/ui_colors.dart';

import 'package:uicons/uicons.dart';

class CarouselEvents {
  String tittle;
  int quota;
  String posterUrl;
  String place;
  String location;
  DateTime dateStart;
  String status;
  Color boxColor;

  CarouselEvents({
    required this.tittle,
    required this.quota,
    required this.posterUrl,
    required this.place,
    required this.location,
    required this.dateStart,
    required this.status,
    required this.boxColor,
  });

  //! Isi Category -- nama & warna --
  static List<CarouselEvents> getEvents() {
    List<CarouselEvents> events = [];

    events.add(CarouselEvents(
      tittle: 'Proposed',
      quota: 12,
      posterUrl:
          "https://cdn.pixabay.com/photo/2023/04/20/12/22/globe-7939725_1280.jpg",
      boxColor: UIColor.propose,
      place: "",
      location: "",
      dateStart: DateTime.utc(1989, 11, 9),
      status: "",
    ));
    events.add(CarouselEvents(
      tittle: 'Proposed',
      quota: 12,
      posterUrl:
          "https://drive.google.com/open?id=1kwyK1vJeQwd1OFPWcQ0NLLeEbV9muFxB&usp=drive_fs",
      boxColor: UIColor.propose,
      place: "",
      location: "",
      dateStart: DateTime.utc(1989, 11, 9),
      status: "",
    ));
    events.add(CarouselEvents(
      tittle: 'Proposed',
      quota: 12,
      posterUrl: "",
      boxColor: UIColor.propose,
      place: "",
      location: "",
      dateStart: DateTime.utc(1989, 11, 9),
      status: "",
    ));
    events.add(CarouselEvents(
      tittle: 'Proposed',
      quota: 12,
      posterUrl: "",
      boxColor: UIColor.propose,
      place: "",
      location: "",
      dateStart: DateTime.utc(1989, 11, 9),
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
        padding: EdgeInsets.fromLTRB(20, 32, 20, 16),
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
                  ),
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
                      color: UIColor.bgCarousel,
                      elevation: 10,
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
                                  color: UIColor.bgSolidWhite,
                                  UIcons.regularRounded.user,
                                  size: 12,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text('120 Seat',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: UIColor.bgSolidWhite,
                                    ))
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  color: UIColor.bgSolidWhite,
                                  UIcons.regularRounded.house_flood,
                                  size: 12,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text('GKT Lt. 2',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: UIColor.bgSolidWhite,
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
      const SizedBox(
        height: 20,
      )
    ]);
  }
}
