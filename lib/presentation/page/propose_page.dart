import 'package:event_proposal_app/bloc/bloc.dart';
import 'package:event_proposal_app/presentation/screen/detail_event_screen.dart';

import 'package:event_proposal_app/presentation/screen/search_result_event_screen.dart';
import 'package:event_proposal_app/presentation/widget/event_card_with_status.dart';
import 'package:event_proposal_app/presentation/widget/search_widget.dart';
import 'package:event_proposal_app/presentation/widget/ui_colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HomePropose extends StatefulWidget {
  const HomePropose({super.key});

  @override
  State<HomePropose> createState() => _HomeProposeState();
}

class _HomeProposeState extends State<HomePropose> {
  final ScrollController _scrollController = ScrollController();

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
      context.read<EventBloc>().add(EventFetched());
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
        if (state is EventLoading) {
          // Tampilkan loading spinner
          // showDialog(
          //   context: context,
          //   barrierDismissible: false,
          //   builder: (BuildContext context) {
          //     return const Center(child: CircularProgressIndicator());
          //   },
          // );
        } else if (state is EventSubmited) {
          Navigator.of(context).pop(); // Close loading spinner

          //! Trigger CategoryBloc untuk memuat ulang data kategori
          context.read<EventBloc>().add(EventFetched());
          // } else if (state is EventLoaded) {
          Navigator.of(context).pop();
        } else if (state is EventLoadError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Error loading events")),
          );
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
                          builder: (context) => SearchEventsResultScreen(
                              searchQuery: searchQuery)),
                    );
                  },
                  onPressedFilter: () {
                    // Handle the button tap action here
                    print('Tapped on FILTER ITEM-BUTTON');
                  },
                ), //! memanggil model => search,
              ),
              Expanded(
                child: BlocBuilder<EventBloc, EventState>(
                  builder: (context, state) {
                    if (state is EventLoadError) {
                      return const Center(child: Text('failed to fetch posts'));
                    } else if (state is EventInitial) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is EventLoaded) {
                      final events = state.event;
                      // if (state.hasReachedMax) {
                      //   return const Center(child: Text('no more events'));
                      // } else {
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
                            // } else if (index.state.hasReachedMax) {
                            //   return const Center(
                            //     child: Text("No more events"),
                            //   );
                          } else {
                            //! card event
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                              child: InkWell(
                                onTap: () {
                                  print(
                                      'Tapped on ${state.event[index].tittle}');
                                  //! Isi dengan routing card tab
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailEventScreen(),
                                    ),
                                  );
                                },
                                child: EventCardWithStatusWidget(
                                  tittle: events[index].tittle,
                                  category: events[index].category,
                                  quota: events[index].quota,
                                  posterUrl: events[index].posterUrl,
                                  place: events[index].place,
                                  location: events[index].location,
                                  dateStart: events[index].dateStart,
                                  status: events[index].status,
                                ),
                              ),
                            );
                          }
                        },

                        //! penambahan event
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
