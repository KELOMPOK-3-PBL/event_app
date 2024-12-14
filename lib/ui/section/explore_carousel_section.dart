import 'dart:ui';

import 'package:event_proposal_app/bloc/event_bloc/event_bloc.dart';
import 'package:event_proposal_app/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:event_proposal_app/ui/theme/ui_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uicons_pro/uicons_pro.dart';

import '../widget/card_info.dart';

class CarouselSection extends StatelessWidget {
  final String currentRole;
  // final List<EventDataModel>? eventData;
  final String route;
  const CarouselSection({
    super.key,
    required this.currentRole,
    // required this.eventData,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //! Section Tittle
        Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Text(
            (currentRole == 'Admin' || currentRole == 'Superadmin')
                ? 'Newly Proposed Events'
                : 'Trending Events',
            textAlign: TextAlign.right,
            style: TextStyle(
                color: UIColor.typoBlack,
                fontSize: 16,
                fontWeight: FontWeight.w800),
          ),
        ),
        //! Carousel Content
        BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            if (state is EventLoaded) {
              final eventData = state.listEventsCarousel;
              return CarouselItems(
                  eventData: eventData, route: route, currentRole: currentRole);
            } else if (state is EventLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(child: Text('No Carousel Data'));
            }
          },
        ),
      ],
    );
  }
}

class CarouselItems extends StatelessWidget {
  const CarouselItems({
    super.key,
    required this.eventData,
    required this.route,
    required this.currentRole,
  });

  final List<EventDataModel>? eventData;
  final String route;
  final String currentRole;

  @override
  Widget build(BuildContext context) {
    if (eventData!.isEmpty) {
      return Center(
        child: Text('No Data'),
      );
    } else {
      return SizedBox(
        height: (MediaQuery.of(context).size.width - 40) / 1.66,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: (eventData!.length <= 5) ? eventData!.length : 5,
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
                //     .add(EventCardPressed(eventData![index]));
                Navigator.pushNamed(
                  context,
                  route,
                  arguments: {
                    'event_data': eventData![index],
                    'current_role': currentRole
                  },
                );
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        eventData![index].posterUrl!,
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fitWidth,
                        width: MediaQuery.of(context).size.width - 40,
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          // Menampilkan gambar error jika gambar gagal dimuat
                          return Image.asset(
                            'assets/images/image_not_found.png',
                            width: double.infinity,
                            alignment: Alignment.center,
                            fit: BoxFit.fitWidth,
                          );
                        },
                      ),
                    ),
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
                                              "${eventData![index].category} : ${eventData![index].title}",
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
                                            "${eventData![index].quota} Participants"),
                                        cardInfoCarouselRow(
                                            UIconsPro
                                                .regularRounded.house_building,
                                            eventData![index].place),
                                        cardInfoCarouselRow(
                                            UIconsPro.regularRounded.marker,
                                            eventData![index].location!),
                                        cardInfoCarouselRow(
                                            UIconsPro.regularRounded.calendar,
                                            eventData![index].dateStart),
                                      ],
                                    ),
                                    StatusOrSeeMore(
                                      status: eventData![index].status,
                                      currentRole: currentRole,
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
      );
    }
  }
}

class StatusOrSeeMore extends StatelessWidget {
  final String status;
  final String currentRole;

  const StatusOrSeeMore({
    super.key,
    required this.status,
    required this.currentRole,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 108,
          height: 31,
          decoration: BoxDecoration(
              color: (currentRole == 'Admin' || currentRole == 'Superadmin')
                  ? UIColor.getStatusColor(status)
                  : UIColor.reviewing,
              borderRadius: BorderRadius.circular(30)),
          child: Text(
            (currentRole == 'Admin' || currentRole == 'Superadmin')
                ? status
                : 'See detail',
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: UIColor.solidWhite,
                height: 2.5,
                fontWeight: FontWeight.w600,
                fontSize: 12),
          ),
        ),
      ],
    );
  }
}
