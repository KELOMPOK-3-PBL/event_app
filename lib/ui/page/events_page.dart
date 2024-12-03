import 'package:event_proposal_app/data/model/model.dart';
import 'package:event_proposal_app/data/provider/provider.dart';

import '../../bloc/bloc.dart';

import '../router/router.dart';
import '../widget/event_card_widget.dart';
import '../widget/search_widget.dart';
import '../widget/show_error.dart';
import '../theme/ui_colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HomeEventsPage extends StatefulWidget {
  const HomeEventsPage({super.key});

  @override
  State<HomeEventsPage> createState() => _HomeEventsPageState();
}

class _HomeEventsPageState extends State<HomeEventsPage>
// with AutomaticKeepAliveClientMixin
{
  // @override
  // bool get wantKeepAlive => true;

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
    // mencari role untuk menyesuaikan output
    // final roles = .authData.data?.roles;
    currentRole = (authState as AuthAuthenticated).currentRole!;
    // token =
    //     (context.read<AuthBloc>().state as AuthAuthenticated).authData.token!;

    //! Inisiasi request pertama
    // requestFilteredEvent = RequestFilteredEventModel(
    //   token: token,
    //   currentIndex: '0',
    // );

    // context.read<EventBloc>().add(EventFetchData(
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
    if (_isBottom
        // &&!(context.read<EventBloc>().state as EventApprovedLoaded)
        // .hasReachedMax
        ) {
      //! mengatasi perubahan request ketika di scroll
      // mengambil request yang sudah diubah current statenya
      // requestFilteredEvent =
      //     (context.read<EventBloc>().state as EventLoaded).requestEvent;
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
        if (state is EventLoaded) {
          //! Mengambil data request event
          requestFilteredEvent = state.requestEvent;
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
                    Navigator.pushNamed(
                        context, AppRouter.searchResultEventRoute,
                        arguments: {'search_query': searchQuery});
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => SearchResultEventsScreen(
                    //           searchQuery: searchQuery)),
                    // );
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
                        return Center(
                          child: Text('There are no events to attend'),
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
                                  Navigator.pushNamed(
                                      context, AppRouter.detailEventRoute,
                                      arguments: {'event_data': events[index]});
                                  // context
                                  //     .read<EventBloc>()
                                  //     .add(EventCardPressed(events[index]));
                                },
                                child: EventCardWidget(
                                  events: events[index],
                                  currentRole: currentRole!,
                                  showStatus: false,
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
