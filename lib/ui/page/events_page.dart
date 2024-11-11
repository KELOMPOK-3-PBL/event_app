import 'package:event_proposal_app/data/model/model.dart';

import '../../bloc/bloc.dart';

import '../../data/provider/provider.dart';
import '../router/router.dart';
import '../screen/search_result_event_screen.dart';
import '../widget/event_card.dart';
import '../widget/search_widget.dart';
import '../widget/show_error.dart';
import '../widget/ui_colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HomeEventsPage extends StatefulWidget {
  const HomeEventsPage({super.key});

  @override
  State<HomeEventsPage> createState() => _HomeEventsPageState();
}

class _HomeEventsPageState extends State<HomeEventsPage> {
  final ScrollController _scrollController = ScrollController();

  late String token;

  //! Updated request
  late RequestFilteredEventModel requestFilteredEvent;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    token =
        (context.read<AuthBloc>().state as AuthAuthenticated).authData.token!;

    // requestFilteredEvent = RequestFilteredEventModel(
    //   token: token,
    //   currentIndex: '0',
    // );

    // context.read<EventBloc>().add(EventFetchAllData(
    //       requestEvent: requestFilteredEvent,
    //     ));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onScroll() {
    // if (_isBottom) {
    if (_isBottom &&
        !(context.read<EventBloc>().state as EventLoaded).hasReachedMax) {
      //! mengatasi perubahan request ketika di scroll
      // mengambil request yang sudah diubah current statenya
      requestFilteredEvent =
          (context.read<EventBloc>().state as EventLoaded).requestEvent;
      // requestEvent.copyWith();
      context.read<EventBloc>().add(
            EventFetchData(
              requestEvent: requestFilteredEvent,
              pathRequest: PathRequestEvents.approvedEvents,
            ),
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
    return BlocListener<EventBloc, EventState>(
      listener: (context, state) {
        //! Mengambil token
        // final authState = context.read<AuthBloc>().state;
        // token = (authState as AuthAuthenticated).authData.token!;
        // debugPrint("Token: $token");

        if (state is EventSubmited) {
          // debugPrint("event submited");

          // Navigator.of(context).pop(); // Close loading spinner
          Navigator.pushNamed(context, AppRouter.detailEventRoute,
              arguments: state.event);

          //! Trigger CategoryBloc untuk memuat ulang data kategori
          // context.read<EventBloc>().add(EventFetchApprovedData(
          //       requestEvent: requestFilteredEvent,
          //     ));
          // } else if (state is EventLoaded) {
          // Navigator.of(context).pop();
        } else if (state is EventLoadError) {
          debugPrint("load error");
          showError(context, state.message);
        }
      },
      // builder: (context, state) {
      //   if (state is EventLoaded) {
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false, // remove leading(left) back icon
            centerTitle: true,
            backgroundColor: UIColor.solidWhite,
            scrolledUnderElevation: 0,
            title: Text(
              "Events",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: UIColor.typoBlack,
              ),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: SearchWidget(
                  label: 'Search Event ...',
                  onSubmittedKeyboard: (searchQuery) {
                    //! pencarian approval menu
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchResultEventsScreen(
                              searchQuery: searchQuery)),
                    );
                  },
                  onPressedFilter: () {
                    // Handle the button tap action here
                    debugPrint('Tapped on FILTER ITEM-BUTTON');
                  },
                ), //! memanggil model => search,
              ),
              Expanded(
                child: BlocBuilder<EventBloc, EventState>(
                  builder: (context, state) {
                    if (state is EventLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is EventLoaded) {
                      final events = state.event;
                      debugPrint("List data: $events");
                      return ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.zero,
                        physics: const AlwaysScrollableScrollPhysics(),

                        //! builder card event approval menu with INDEX
                        itemBuilder: (context, index) {
                          final events = state.event;
                          if (index >= events.length) {
                            //! Loader ditampilkan hanya ketika belum mencapai batas maksimum data
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 20),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else {
                            //! card event
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<EventBloc>()
                                      .add(EventCardPressed(events[index]));
                                },
                                child: EventCard(
                                  events: events[index],
                                ),
                              ),
                            );
                          }
                        },

                        //! penambahan event
                        // itemCount: state is EventLoadedMax
                        itemCount: state.hasReachedMax
                            ? events.length
                            : events.length + 1,
                      );
                      // }
                    }
                    return SizedBox();
                  },
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
  // return SizedBox();
}
