import 'dart:ui';

import 'package:event_proposal_app/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:event_proposal_app/ui/theme/ui_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uicons_pro/uicons_pro.dart';

import '../../bloc/bloc.dart';
import '../router/router.dart';
import '../widget/card_info_row.dart';

class CarouselSection extends StatefulWidget {
  const CarouselSection({super.key});

  @override
  State<CarouselSection> createState() => _CarouselEventsState();
}

class _CarouselEventsState extends State<CarouselSection> {
  // List<CarouselEventsModel> _eventsCarousel = [];

  @override
  void initState() {
    super.initState();
    // eventData = getEventsCarousel();
  }

  @override
  Widget build(BuildContext context) {
    // return BlocConsumer<EventBloc, EventState>(
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state is EventLoaded) {
          if (state.listEventsCarousel!.isEmpty) {
            return Center();
          }
          return ExploreCarousel(eventData: state.listEvents);
        } else {
          return Center(
            child: Text("No Data"),
          );
        }
      },
    );
  }
}

class ExploreCarousel extends StatelessWidget {
  final List<EventDataModel> eventData;
  const ExploreCarousel({
    super.key,
    required this.eventData,
  });

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
        // Stack(
        //   children: [
        //     ClipRRect(
        //       borderRadius: BorderRadius.circular(12),
        //       child: Image.network(
        //         "eventData[index].posterUrl!",
        //         fit: BoxFit.cover,
        //         alignment: Alignment.topCenter,
        //         errorBuilder: (context, error, stackTrace) {
        //           return Image.asset(
        //             'assets/images/image_not_found.png',
        //             fit: BoxFit.cover,
        //           );
        //         },
        //       ),
        //     ),
        //   ],
        // ),
        SizedBox(
          height: (MediaQuery.of(context).size.width - 40) / 1.66,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: eventData.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
            separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // context
                  //     .read<EventBloc>()
                  //     .add(EventCardPressed(eventData[index]));
                  Navigator.pushNamed(
                      context, AppRouter.detailEventApprovalRoute,
                      arguments: eventData[index].eventId);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                      color: UIColor.solidWhite,
                      image: DecorationImage(
                          // image: AssetImage('assets/images/image_welcome.png'),
                          image: NetworkImage(eventData[index].posterUrl!),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter),
                      borderRadius: BorderRadius.circular(12)),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: BackdropFilter(
                                blendMode: BlendMode.src,
                                //! menambahkan efek blur
                                filter: ImageFilter.blur(
                                    sigmaX: 4,
                                    sigmaY: 4,
                                    tileMode: TileMode.repeated),
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                  color: UIColor.bgCarousel.withOpacity(0.4),
                                  child: Stack(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    children: [
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.end,
                                      //   children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                overflow: TextOverflow.clip,
                                                "${eventData[index].category} : ${eventData[index].title}",
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: UIColor.solidWhite,
                                                ),
                                                textAlign: TextAlign.left,
                                              )
                                            ],
                                          ),
                                          cardInfoCarouselRow(
                                              UIconsPro.regularRounded.user,
                                              eventData[index].quota),
                                          cardInfoCarouselRow(
                                              UIconsPro.regularRounded
                                                  .house_building,
                                              eventData[index].place),
                                          cardInfoCarouselRow(
                                              UIconsPro.regularRounded.marker,
                                              eventData[index].location!),
                                          cardInfoCarouselRow(
                                              UIconsPro.regularRounded.calendar,
                                              eventData[index].dateStart),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 108,
                                            height: 31,
                                            decoration: BoxDecoration(
                                                color: UIColor.getStatusColor(
                                                    eventData[index].status),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Text(
                                              eventData[index].status,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: UIColor.solidWhite,
                                                  height: 2.5,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      // ClipRRect(
                      //   // borderRadius: BorderRadius.circular(12),
                      //   child: Image.network(
                      //     eventData[index].posterUrl!,
                      //     fit: BoxFit.cover,
                      //     alignment: Alignment.topCenter,
                      //     errorBuilder: (context, error, stackTrace) {
                      //       return Image.asset(
                      //         'assets/images/image_not_found.png',
                      //         fit: BoxFit.scaleDown,
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
