// import 'package:event_proposal_app/ui/theme/ui_colors.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:uicons_pro/uicons_pro.dart';
// import 'package:flutter/material.dart';

// import '../../bloc/bloc.dart';
// import '../../data/model/model.dart';
// import '../router/router.dart';
// import '../widget/show_error.dart';

// class EventListSection extends StatefulWidget {
//   final ScrollController scrollController;
//   final RequestFilteredEventModel requestFilteredEvent;

//   const EventListSection(
//       {super.key,
//       required this.scrollController,
//       required this.requestFilteredEvent});

//   @override
//   State<EventListSection> createState() => _EventListWidgetState();
// }

// class _EventListWidgetState extends State<EventListSection> {
//   // final ScrollController scrollController;

//   // _EventListWidgetState() : super;

//   // // List<EventsMore> state.event = [];
//   // //! Updated request
//   // late RequestFilteredEventModel requestFilteredEvent;

//   @override
//   // void initState() {
//   // _scrollController.addListener(_onScroll);
//   // super.initState();
//   // _eventsMore = getEventsMore();
//   // }

//   // bool get _isBottom {
//   //   if (!_scrollController.hasClients) return false;
//   //   final maxScroll = _scrollController.position.maxScrollExtent;
//   //   final currentScroll = _scrollController.offset;
//   //   return currentScroll >= (maxScroll * 0.9);
//   // }

//   // void _onScroll() {
//   //   if (_isBottom
//   //       // && !(context.read<EventBloc>().state as EventAllLoaded).hasReachedMax
//   //       ) {
//   //     //! mengatasi perubahan request ketika di scroll
//   //     context.read<EventBloc>().add(
//   //           EventFetchAllData(
//   //             requestEvent: requestFilteredEvent,
//   //           ),
//   //         );
//   //   }
//   // }

//   // @override
//   // void dispose() {
//   //   _scrollController.dispose();
//   //   super.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<EventBloc, EventState>(listener: (context, state) {
//       if (state is EventSubmited) {
//         // debugPrint("event submited");
//         Navigator.pushNamed(context, AppRouter.detailEventApprovalRoute,
//             arguments: state.event);

//         // Navigator.of(context).pop(); // Close loading spinner
//         context.read<EventBloc>().add(EventFetchAllData(
//               requestEvent: requestFilteredEvent,
//             ));
//       } else if (state is EventAllLoaded) {
//         requestFilteredEvent = state.requestEvent;
//         debugPrint("New Request: ${requestFilteredEvent.toString()}");
//         // Navigator.of(context).pop();
//       } else if (state is EventLoadError) {
//         debugPrint("load error");
//         showError(context, state.message);
//       }
//     }, builder: (context, state) {
//       if (state is EventLoading) {
//         return const Center(child: CircularProgressIndicator());
//       } else if (state is EventAllLoaded) {
//         // return ExploreCard<EventAllLoaded>(
//         // eventsMore: _eventsMore,
//         // state: state,
//         // );

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(
//               padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
//               child: Text(
//                 'Events Available',
//                 textAlign: TextAlign.right,
//                 style: TextStyle(
//                     color: UIColor.typoBlack,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w800),
//               ),
//             ),
//             const SizedBox(height: 12),
//             // Padding(
//             //   padding: const EdgeInsets.symmetric(horizontal: 16),
//             //   child:
//             SizedBox(
//               child: GridView.builder(
//                 itemCount: state.hasReachedMax
//                     ? state.event.length
//                     : state.event.length + 1,
//                 controller: scrollController,
//                 padding: EdgeInsets.zero,
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2, // Jumlah kolom
//                   crossAxisSpacing: 10, // Jarak horizontal antar kolom
//                   mainAxisSpacing: 10, // Jarak vertikal antar baris
//                   // childAspectRatio: 1, // Rasio lebar-tinggi setiap item
//                 ),
//                 itemBuilder: (context, index) {
//                   if (index >= state.event.length) {
//                     return Padding(
//                       padding: const EdgeInsets.only(top: 10, bottom: 20),
//                       child: const Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                     );
//                   } else {
//                     return GestureDetector(
//                       onTap: () {
//                         context
//                             .read<EventBloc>()
//                             .add(EventCardPressed(state.event[index]));
//                       },
//                       child: Container(
//                         // width: (MediaQuery.of(context).size.width - 44) /
//                         // 2, // Adaptive width for two columns
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: UIColor.solidWhite,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment
//                               .start, // Align contents to the start
//                           children: [
//                             //! Section Tittle
//                             Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: Card(
//                                 elevation: 0,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(6),
//                                   child:
//                                       // Image.asset('assets/images/background.png',
//                                       Image.network(
//                                     state.event[index].posterUrl!,
//                                     height: (MediaQuery.of(context).size.width -
//                                             44) /
//                                         3, // Adjust image size
//                                     width: double.infinity,
//                                     alignment: Alignment.topCenter,
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (BuildContext context,
//                                         Object error, StackTrace? stackTrace) {
//                                       // Menampilkan gambar error jika gambar gagal dimuat
//                                       return Image.asset(
//                                         'assets/images/image_not_found.png',
//                                         height:
//                                             (MediaQuery.of(context).size.width -
//                                                     44) /
//                                                 3,
//                                         width: double.infinity,
//                                         fit: BoxFit.cover,
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             //! Content
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // const SizedBox(height: 0),
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       color: UIColor.getStatusColor(
//                                           state.event[index].status),
//                                       borderRadius: BorderRadius.circular(6),
//                                     ),
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 2, horizontal: 10),
//                                     child: Text(
//                                       state.event[index].status,
//                                       style: const TextStyle(
//                                         color: UIColor.solidWhite,
//                                         fontSize: 10,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     '${state.event[index].category} : ${state.event[index].title}',
//                                     style: const TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.bold,
//                                       color: UIColor.typoBlack,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Row(
//                                     children: [
//                                       Icon(
//                                         UIconsPro.regularRounded.user_time,
//                                         color: UIColor.typoGray,
//                                         size: 10,
//                                       ),
//                                       const SizedBox(width: 4),
//                                       Text(
//                                         '${state.event[index].quota} participants',
//                                         style: const TextStyle(
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.w400,
//                                           color: UIColor.typoBlack,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   // const SizedBox(height: 4),
//                                   Row(
//                                     children: [
//                                       Icon(
//                                         UIconsPro.regularRounded.house_building,
//                                         color: UIColor.typoGray,
//                                         size: 10,
//                                       ),
//                                       const SizedBox(width: 4),
//                                       Text(
//                                         state.event[index].place,
//                                         style: const TextStyle(
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.w400,
//                                           color: UIColor.typoBlack,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   // const SizedBox(height: 4),
//                                   Row(
//                                     children: [
//                                       Icon(
//                                         UIconsPro.regularRounded.marker,
//                                         color: UIColor.typoGray,
//                                         size: 10,
//                                       ),
//                                       const SizedBox(width: 4),
//                                       Text(
//                                         state.event[index].location!,
//                                         style: const TextStyle(
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.w400,
//                                           color: UIColor.typoBlack,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   // const SizedBox(height: 4),
//                                   Row(
//                                     children: [
//                                       Icon(
//                                         UIconsPro.regularRounded.calendar,
//                                         color: UIColor.typoGray,
//                                         size: 10,
//                                       ),
//                                       const SizedBox(width: 4),
//                                       Text(
//                                         state.event[index].dateStart,
//                                         style: const TextStyle(
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.w400,
//                                           color: UIColor.typoBlack,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                           ],
//                         ),
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ),
//             // ),
//             // const SizedBox(
//             //   height: 14,
//             // ),
//           ],
//         );
//       } else {
//         return Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 20),
//             child: Text("No Data"),
//           ),
//         );
//       }
//     });
//   }
// }
