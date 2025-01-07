import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uicons_pro/uicons_pro.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/event_bloc/event_bloc.dart';
import '../../data/model/model.dart';
import '../../data/provider/provider.dart';
import '../router/router.dart';
import '../theme/ui_colors.dart';
import '../widget/event_card_widget.dart';
import '../widget/filter_bottom_sheet.dart';
import '../widget/search_widget.dart';

class SearchResultEventsScreen extends StatefulWidget {
  const SearchResultEventsScreen({super.key, this.searchValue});

  final String? searchValue;

  @override
  State<SearchResultEventsScreen> createState() =>
      _SearchResultEventsScreenState();
}

class _SearchResultEventsScreenState extends State<SearchResultEventsScreen> {
  final ScrollController _scrollController = ScrollController();
  RequestFilteredEventModel? requestFilteredEvent;
  String? currentRole;
  String? token;
  String route = AppRouter.detailEventRoute;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      currentRole = authState.currentRole;
      token = authState.authData.accessToken;
      if (currentRole == 'Admin' || currentRole == 'Superadmin') {
        route = AppRouter.detailEventApprovalProposeRoute;
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<EventBloc>().add(
            EventFetchData(
              requestEvent: requestFilteredEvent!,
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
        if (state is EventLoading) {
          setState(() {
            isSearching = true;
          });
        } else if (state is EventsListLoaded) {
          setState(() {
            isSearching = false;
            requestFilteredEvent = state.requestEvent;
          });
        } else if (state is EventError) {
          setState(() {
            isSearching = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(UIconsPro.regularRounded.angle_small_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          backgroundColor: UIColor.solidWhite,
          scrolledUnderElevation: 0,
          title: const Text(
            "Search Result",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: UIColor.typoBlack,
            ),
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                  child: SearchWidget(
                    value: widget.searchValue,
                    label: 'Search Event ...',
                    onSubmittedKeyboard: (searchQuery) {
                      final request = requestFilteredEvent!.copyWith(
                        search: searchQuery,
                      );
                      Navigator.pushNamed(
                        context,
                        AppRouter.searchResultEventRoute,
                        arguments: {'request_search': request},
                      );
                    },
                    onPressedFilter: () async {
                      RequestFilteredEventModel requestSearch;
                      requestSearch = await showModalBottomSheet(
                        backgroundColor: UIColor.solidWhite,
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (_) {
                          return FilterBottomSheet(
                            requestEvent: requestFilteredEvent,
                            currentRoe: currentRole!,
                            token: token!,
                          );
                        },
                      );
                      if (context.mounted) {
                        Navigator.of(context).pushNamed(
                            AppRouter.searchResultEventRoute,
                            arguments: {
                              'request_search': requestSearch.copyWith(
                                  isAllEvent: (currentRole == 'Propose' ||
                                          currentRole == 'Member')
                                      ? false
                                      : true),
                              'token': token
                            });
                      }

                      debugPrint(requestSearch.toString());
                    },
                    onChangedKeyboard: (_) {},
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<EventBloc>().add(
                            EventFetchData(
                              isReload: true,
                              requestEvent: requestFilteredEvent!,
                              pathRequest: (requestFilteredEvent!.isAllEvent)
                                  ? PathRequestEvents.events
                                  : PathRequestEvents.approvedEvents,
                            ),
                          );
                    },
                    child: BlocBuilder<EventBloc, EventState>(
                      builder: (context, state) {
                        if (state is EventsListLoaded) {
                          final events = state.event;
                          if (events.isEmpty) {
                            return const Center(
                              child: Text('There are no events to attend'),
                            );
                          }
                          return ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.zero,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (index >= events.length) {
                                return const Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 20),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      debugPrint(currentRole);
                                      Navigator.pushNamed(
                                        context,
                                        // (currentRole != 'Admin' ||
                                        //         currentRole != 'Superadmin')
                                        //     ? AppRouter.detailEventRoute
                                        //     : AppRouter
                                        //         .detailEventApprovalProposeRoute,
                                        route,
                                        arguments: {
                                          'event_data': events[index],
                                          'current_role': currentRole,
                                        },
                                      );
                                    },
                                    child: EventCardWidget(
                                      events: events[index],
                                      showStatus: (currentRole == 'Admin' ||
                                              currentRole == 'Superadmin')
                                          ? true
                                          : false,
                                    ),
                                  ),
                                );
                              }
                            },
                            itemCount: state.hasReachedMax
                                ? events.length
                                : events.length + 1,
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ),
              ],
            ),
            if (isSearching)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
