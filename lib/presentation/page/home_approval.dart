import 'package:event_proposal_app/bloc/bloc.dart';
import 'package:event_proposal_app/presentation/screen/detail_event_screen.dart';

import 'package:event_proposal_app/presentation/screen/search_result_event_screen.dart';
import 'package:event_proposal_app/presentation/widget/event_card_with_status.dart';
import 'package:event_proposal_app/presentation/widget/search_widget.dart';
import 'package:event_proposal_app/presentation/widget/ui_colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HomeApproval extends StatelessWidget {
  const HomeApproval({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventBloc, EventState>(
      listener: (context, state) {
        if (state is EventLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Center(child: CircularProgressIndicator());
            },
          );
        } else if (state is EventSubmited) {
          Navigator.of(context).pop(); // Close loading spinner

          //! Trigger CategoryBloc untuk memuat ulang data kategori
          context.read<EventBloc>().add(FetchEvent());
        } else if (state is EventLoaded) {
          Navigator.of(context).pop();
        } else if (state is EventError) {}
      },
      builder: (context, state) {
        if (state is EventLoaded) {
          return Column(children: [
            AppBar(
              automaticallyImplyLeading:
                  false, // remove leading(left) back icon
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
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.event.length,
                    //! builder card event approval menu with INDEX
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                        // child: _buildEventCard(_events[index]),
                        child: InkWell(
                          onTap: () {
                            print('Tapped on ${state.event[index].tittle}');
                            //! Isi dengan routing card tab
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailEventScreen(),
                              ),
                            );
                          },
                          child: EventCardWithStatusWidget(
                            tittle: state.event[index].tittle,
                            category: state.event[index].category,
                            quota: state.event[index].quota,
                            posterUrl: state.event[index].posterUrl,
                            place: state.event[index].place,
                            location: state.event[index].location,
                            dateStart: state.event[index].dateStart,
                            status: state.event[index].status,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ))
          ]);
        }
        return SizedBox();
      },
    );
  }
}
