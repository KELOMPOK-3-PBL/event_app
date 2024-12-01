import 'package:event_proposal_app/data/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uicons_pro/uicons_pro.dart';
import '../../bloc/bloc.dart';
import '../../data/model/model.dart';
import '../router/router.dart';
// import '../section/explore_event_list_section.dart';
import '../section/explore_quick_category_section.dart';
import '../section/explore_carousel_section.dart';
import '../theme/ui_colors.dart';
import '../widget/search_widget.dart';
import '../widget/show_error.dart';

class HomeExplorePage extends StatefulWidget {
  final String token;
  const HomeExplorePage({super.key, required this.token});

  @override
  State<HomeExplorePage> createState() => _HomeExplorePageState();
}

class _HomeExplorePageState extends State<HomeExplorePage> {
  // final GlobalKey<SearchEventsWidgetState> _searchKey =
  //     GlobalKey<SearchEventsWidgetState>();
  // List<EventsMore> state.event = [];

  final ScrollController _scrollController = ScrollController();

  //! Updated request
  late RequestFilteredEventModel requestFilteredEvent;
  PathRequestEvents requestPath = PathRequestEvents.approvedEvents;
  // late EventFetchData eventFetchData;

  String route = AppRouter.detailEventRoute;
  String? currentRole;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // _eventsMore = getEventsMore();
    final authState = context.read<AuthBloc>().state;
    // mencari role untuk menyesuaikan output
    final roles = (authState as AuthAuthenticated).authData.data?.roles;
    currentRole = (authState).currentRole!;

    if (roles!.contains('Admin') || roles.contains('Superadmin')) {
      requestPath = PathRequestEvents.events;
      route = AppRouter.detailEventApprovalRoute;
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onScroll() {
    if (_isBottom
        // &&!(context.read<EventBloc>().state as EventLoaded).hasReachedMax
        ) {
      //! mengatasi perubahan request ketika di scroll
      context.read<EventBloc>().add(
            EventFetchData(
                requestEvent: requestFilteredEvent, pathRequest: requestPath),
          );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit:
                    BoxFit.cover, // Set the image to cover the entire container
              ),
              border: Border.all(
                color: Colors.blue, // Set the border color to white
                width: 0, // Set the border width to 1
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Hi, Fattur 👋',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'You are logged in as superadmin',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 63),
                SearchWidget(
                  label: 'Search Event ...',
                  onSubmittedKeyboard: (searchQuery) {
                    Navigator.pushNamed(
                        context, AppRouter.searchResultEventRoute,
                        arguments: {'search_query': searchQuery});
                  },
                  onPressedFilter: () {
                    // Handle the button tap action here
                    debugPrint('Tapped on FILTER ITEM-BUTTON');
                  },
                ), //! memanggil model => search
                const SizedBox(height: 4),
              ],
            ),
          ),
          const SizedBox(
            height: 14,
          ),

          QuickCategorySection(), //! memanggil model => category
          // BlocProvider(
          //   create: (context) => EventBloc()
          //     ..add(EventFetchData(
          //         requestEventCarousel: ,
          //         requestEvent: RequestFilteredEventModel(
          //             token: widget.token,
          //             currentIndex: '0',
          //             status: 'Proposed'),
          //         pathRequest: PathRequestEvents.allEvents)),
          // child:
          // CarouselSection(),
          // ), //! -- Carousel Events Section
          // EventListSection(
          //   scrollController: _scrollController,
          //   requestFilteredEvent: requestFilteredEvent,
          // ) //! -- Events Available Section
          BlocConsumer<EventBloc, EventState>(listener: (context, state) {
            // if (state is EventSubmited) {
            //   // debugPrint("event submited");
            //   Navigator.pushNamed(context, AppRouter.detailEventApprovalRoute,
            //       arguments: state.event);

            //   // Navigator.of(context).pop(); // Close loading spinner
            //   context.read<EventBloc>().add(EventFetchData(
            //         requestEvent: requestFilteredEvent,
            //       ));
            // } else
            if (state is EventLoaded) {
              // final authState = context.read<AuthBloc>().state;
              // // mencari role untuk menyesuaikan output
              // final roles =
              //     (authState as AuthAuthenticated).authData.data?.roles;

              // if (roles!.contains('Propose')) {
              //   pathRequest = PathRequestEvents.events;
              // } else if (roles.contains('Admin') ||
              //     roles.contains('Superadmin')) {
              //   pathRequest = PathRequestEvents.approvedEvents;
              // }

              requestFilteredEvent = state.requestEvent;
              // pathRequest = state.pathRequest!;
              // debugPrint("New Request: ${requestFilteredEvent.toString()}");
              // Navigator.of(context).pop();
            } else if (state is EventLoadError) {
              debugPrint("load error");
              showError(context, state.message);
            }
          }, builder: (context, state) {
            if (state is EventLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EventLoaded) {
              // return ExploreCard<EventLoaded>(
              // eventsMore: _eventsMore,
              // state: state,
              // );

              return SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSection(
                        currentRole: currentRole ?? '',
                        eventData: state.listEventsCarousel ?? [],
                        route: route),

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
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16),
                    //   child:
                    Padding(
                        padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
                        child: Wrap(
                          spacing: 10, // Jarak horizontal antar item
                          runSpacing: 10, // Jarak vertikal antar baris
                          children: List.generate(
                            state.hasReachedMax
                                ? state.event.length
                                : state.event.length + 1,
                            (index) {
                              if (index >= state.event.length) {
                                return SizedBox(
                                  // width: MediaQuery.of(context).size.width / 2 -
                                  //     18, // Lebar untuk 2 kolom
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 20),
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox(
                                  width:
                                      (MediaQuery.of(context).size.width / 2) -
                                          25, // Lebar untuk 2 kolom
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        route,
                                        arguments: state.event[index],
                                      );
                                    },
                                    child: ExploreCard(
                                      currentRole: currentRole!,
                                      eventData: state.event[index],
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        )),
                    // ),
                    // const SizedBox(
                    //   height: 14,
                    // ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text("No Data"),
                ),
              );
            }
          })
        ],
      ),
    );
  }
}

class ExploreCard extends StatelessWidget {
  const ExploreCard({
    super.key,
    required this.currentRole,
    required this.eventData,
  });

  final String currentRole;
  final EventDataModel eventData;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: (MediaQuery.of(context).size.width - 44) /
      // 2, // Adaptive width for two columns
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: UIColor.solidWhite,
      ),
      child:
          // Text("Apa")
          Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align contents to the start
        children: [
          // ! Section Tittle
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child:
                  // Image.asset('assets/images/background.png',
                  Image.network(
                eventData.posterUrl!,
                height: (MediaQuery.of(context).size.width - 44) /
                    3, // Adjust image size
                width: double.infinity,
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  // Menampilkan gambar error jika gambar gagal dimuat
                  return Image.asset(
                    'assets/images/image_not_found.png',
                    height: (MediaQuery.of(context).size.width - 44) / 3,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          //! Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 0),
                if (currentRole == 'Admin' || currentRole == 'Superadmin')
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: UIColor.getStatusColor(eventData.status),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    child: Text(
                      eventData.status,
                      style: const TextStyle(
                        color: UIColor.solidWhite,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                const SizedBox(height: 4),
                Text(
                  '${eventData.category} : ${eventData.title}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: UIColor.typoBlack,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      UIconsPro.regularRounded.user_time,
                      color: UIColor.typoGray,
                      size: 10,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${eventData.quota} participants',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: UIColor.typoBlack,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      UIconsPro.regularRounded.house_building,
                      color: UIColor.typoGray,
                      size: 10,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      eventData.place,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: UIColor.typoBlack,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      UIconsPro.regularRounded.marker,
                      color: UIColor.typoGray,
                      size: 10,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      eventData.location!,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: UIColor.typoBlack,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      UIconsPro.regularRounded.calendar,
                      color: UIColor.typoGray,
                      size: 10,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      eventData.dateStart,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: UIColor.typoBlack,
                      ),
                    )
                  ],
                ),
                if (currentRole == 'Member' || currentRole == 'Propose')
                  Container(
                    margin: EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                      color: UIColor.reviewing,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    child: Text(
                      'See detail',
                      style: const TextStyle(
                        color: UIColor.solidWhite,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
