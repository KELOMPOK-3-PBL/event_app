import 'package:event_proposal_app/data/model/model.dart';
import 'package:event_proposal_app/data/provider/provider.dart';

import '../../bloc/bloc.dart';

import '../router/router.dart';
import '../screen/search_result_event_screen.dart';
import '../widget/event_card_widget.dart';
import '../widget/search_widget.dart';
import '../widget/show_error.dart';
import '../theme/ui_colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HomeProposePage extends StatefulWidget {
  const HomeProposePage({super.key});

  @override
  State<HomeProposePage> createState() => _HomeProposePageState();
}

class _HomeProposePageState extends State<HomeProposePage> {
  final ScrollController _scrollController = ScrollController();

  // late String token;

  //! Updated request
  late RequestFilteredEventModel requestFilteredEvent;
  String? currentRole;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    final authState = context.read<AuthBloc>().state;

    if (authState is AuthAuthenticated) {
      currentRole = authState.currentRole!;
    }

    // token =
    //     (context.read<AuthBloc>().state as AuthAuthenticated).authData.token!;

    // //! Inisiasi request pertama
    // requestFilteredEvent = RequestFilteredEventModel(
    //   token: token,
    //   currentIndex: '0',
    // );

    // context.read<EventBloc>().add(EventFetchData(
    //       requestEvent: requestFilteredEvent, pathRequest: null,
    //     ));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onScroll() {
    if (_isBottom &&
        !(context.read<EventBloc>().state as EventLoaded).hasReachedMax) {
      //! mengatasi perubahan request ketika di scroll
      // mengambil request yang sudah diubah current statenya
      // requestFilteredEvent =
      //     (context.read<EventBloc>().state as EventLoaded).requestEvent;
      // requestEvent.copyWith();
      context.read<EventBloc>().add(
            EventFetchData(
              requestEvent: requestFilteredEvent,
              pathRequest: PathRequestEvents.events,
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
        // debugPrint("get");
        // debugPrint("Token: $token");

        // if (state is EventSubmited) {
        //   debugPrint("event submited");

        //   Navigator.of(context).pushNamed(AppRouter.detailEventProposeRoute,
        //       arguments: state.event);

        //   //! Trigger CategoryBloc untuk memuat ulang data
        //   context.read<EventBloc>().add(EventFetchData(
        //         requestEvent: requestFilteredEvent,
        //       ));
        // } else
        if (state is EventLoaded) {
          requestFilteredEvent = state.requestEvent;
          // Navigator.of(context).pop();
        } else if (state is EventError) {
          debugPrint("load error");
          showError(context, state.message);
        }
      },
      // builder: (context, state) {
      //   if (state is EventLoaded) {
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<EventBloc>().add(
                EventReloadData(
                    requestEvent: RequestFilteredEventModel(
                      token: requestFilteredEvent.token,
                    ),
                    pathRequest: PathRequestEvents.events),
              );
        },
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading:
                  false, // remove leading(left) back icon
              centerTitle: true,
              backgroundColor: UIColor.solidWhite,
              scrolledUnderElevation: 0,
              title: Text(
                "My Propose",
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
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is EventLoaded) {
                        final events = state.event;
                        if (events.isEmpty) {
                          return const Center(
                            child: Text("You don't propose any events"),
                          );
                        }
                        return ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.zero,
                          physics: const AlwaysScrollableScrollPhysics(),

                          //! builder card event approval menu with INDEX
                          itemBuilder: (context, index) {
                            final events = state.event;
                            if (index >= events.length) {
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
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 8),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        AppRouter
                                            .detailEventApprovalProposeRoute,
                                        arguments: {
                                          'event_data': events[index],
                                          'current_role': currentRole
                                        });
                                    //       arguments: state.event);
                                    // context
                                    //     .read<EventBloc>()
                                    //     .add(EventCardPressed(events[index]));
                                  },
                                  child: EventCardWidget(
                                    events: events[index],
                                    currentRole: currentRole!,
                                    showStatus: true,
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
      ),
    );
  }
  // return SizedBox();
}
