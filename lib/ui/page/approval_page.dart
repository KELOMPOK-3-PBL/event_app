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

class HomeApprovalPage extends StatefulWidget {
  const HomeApprovalPage({super.key});

  @override
  State<HomeApprovalPage> createState() => _HomeApprovalPageState();
}

class _HomeApprovalPageState extends State<HomeApprovalPage> {
  final ScrollController _scrollController = ScrollController();

  // late final String token;

  //! Updated request
  late RequestFilteredEventModel requestFilteredEventApproval;
  String? currentRole;
  String? userId;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    final authState = context.read<AuthBloc>().state;

    if (authState is AuthAuthenticated) {
      currentRole = authState.currentRole!;
      userId = authState.authData.data!.userId;
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
        // && !(context.read<EventBloc>().state as EventLoaded).hasReachedMax
        ) {
      //! mengatasi perubahan request ketika di scroll
      debugPrint("User ID: ${requestFilteredEventApproval.adminUserId}");
      context.read<EventBloc>().add(
            EventFetchData(
              requestEvent: requestFilteredEventApproval,
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
        if (state is EventsListLoaded) {
          //! Mengambil data request event
          requestFilteredEventApproval = state.requestEvent;
          debugPrint("Cek Request ${state.requestEvent.adminUserId}");
        } else if (state is EventError) {
          debugPrint("load error");
          showCustomSnackBar(context, state.message);
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {
          debugPrint("Reload Page");

          context.read<EventBloc>().add(
                EventFetchData(
                    isReload: true,
                    requestEvent: RequestFilteredEventModel(
                      token: requestFilteredEventApproval.token,
                      adminUserId: requestFilteredEventApproval.adminUserId,
                    ),
                    pathRequest: PathRequestEvents.events),
              );
        },
        child: Column(
          children: [
            AppBar(
              shadowColor: UIColor.shadowColor,
              automaticallyImplyLeading:
                  false, // remove leading(left) back icon
              centerTitle: true,
              backgroundColor: UIColor.solidWhite,
              scrolledUnderElevation: 0,
              title: Text(
                "My Approval",
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
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                //   child: SearchWidget(
                //     label: 'Search Event ...',
                //     onSubmittedKeyboard: (searchQuery) {
                //       Navigator.pushNamed(
                //           context, AppRouter.searchResultEventRoute,
                //           arguments: {'search_query': searchQuery});
                //       //! pencarian approval menu
                //       // Navigator.push(
                //       //   context,
                //       //   MaterialPageRoute(
                //       //       builder: (context) => SearchResultEventsScreen(
                //       //           searchQuery: searchQuery)),
                //       // );
                //     },
                //     onPressedFilter: () {
                //       // Handle the button tap action here
                //       debugPrint('Tapped on FILTER ITEM-BUTTON');
                //     },
                //   ), //! memanggil model => search,
                // ),
                SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<EventBloc, EventState>(
                    builder: (context, state) {
                      if (state is EventLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is EventsListLoaded) {
                        final events = state.event;
                        if (events.isEmpty) {
                          return const Center(
                            child: Text("You don't review any events"),
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
                                    Navigator.pushNamed(
                                      context,
                                      AppRouter.detailEventApprovalProposeRoute,
                                      arguments: {
                                        'event_data': state.event[index],
                                        'current_role': currentRole
                                      },
                                    );
                                    // context
                                    //     .read<EventBloc>()
                                    //     .add(EventCardPressed(events[index]));
                                  },
                                  child: EventCardWidget(
                                    events: events[index],
                                    // currentRole: currentRole!,
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
                      } else {
                        return const Center(
                          child: Text("You're never review events"),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 10),
              ],
            ))
          ],
        ),
      ),
    );
  }
  // return SizedBox();
}
