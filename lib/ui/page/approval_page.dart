import 'package:event_proposal_app/data/model/model.dart';

import '../../bloc/bloc.dart';

import '../screen/search_result_event_screen.dart';
import '../widget/event_card_with_status.dart';
import '../widget/search_widget.dart';
import '../widget/show_error.dart';
import '../widget/ui_colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HomeApprovalPage extends StatefulWidget {
  const HomeApprovalPage({super.key});

  @override
  State<HomeApprovalPage> createState() => _HomeApprovalPageState();
}

class _HomeApprovalPageState extends State<HomeApprovalPage> {
  final ScrollController _scrollController = ScrollController();

  late String token;

  //! Updated request
  late RequestFilteredEventModel requestEvent;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onScroll() {
    if (_isBottom) {
      //! mengatasi perubahan request ketika di scroll
      // requestEvent.copyWith();
      context.read<EventBloc>().add(EventFetchData(requestEvent: requestEvent));
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
        final authState = context.read<AuthBloc>().state;
        token = (authState as AuthAuthenticated).authData.token!;
        debugPrint("get");
        debugPrint("Token: $token");

        if (state is EventInitial) {
          debugPrint("Initial fetch event");

          //! Inisialisasi permintaan awal
          context.read<EventBloc>().add(EventFetchData(
              requestEvent:
                  RequestFilteredEventModel(token: token, currentIndex: '0')));
        } else if (state is EventSubmited) {
          debugPrint("event submited");

          Navigator.of(context).pop(); // Close loading spinner

          //! Trigger CategoryBloc untuk memuat ulang data kategori
          context
              .read<EventBloc>()
              .add(EventFetchData(requestEvent: requestEvent));
          // } else if (state is EventLoaded) {
          Navigator.of(context).pop();
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
              "Approval",
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
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                              child: InkWell(
                                onTap: () {
                                  debugPrint(
                                      'Tapped on ${state.event[index].title}');
                                  //! Isi dengan routing card tab
                                  Navigator.pushNamed(
                                      context, '/detailEventApproval');
                                },
                                child: EventCardWithStatusWidget(
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
