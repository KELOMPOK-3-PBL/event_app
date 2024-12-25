import 'package:event_proposal_app/data/model/model.dart';
import 'package:event_proposal_app/ui/section/detail_event_content_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/event_bloc/event_bloc.dart';
import '../theme/ui_colors.dart';

class DetailEventScreen extends StatefulWidget {
  final EventDataModel data;
  final String token;
  const DetailEventScreen({super.key, required this.token, required this.data});

  @override
  DetailEventScreenState createState() => DetailEventScreenState();
}

class DetailEventScreenState extends State<DetailEventScreen> {
  TextEditingController adminNoteController = TextEditingController(text: '-');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EventDataModel? data = widget.data;

    return Scaffold(
      backgroundColor: UIColor.white,
      body: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          if (state is EventLoaded) {
            data = state.eventData;
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<EventBloc>().add(
                    EventGetByID(token: widget.token, eventId: data!.eventId!),
                  );
            },
            child: CustomScrollView(
              slivers: [
                AppBarDetailEvent(
                  data: data!,
                  title: 'Detail Event',
                ),
                BodyDetailEvent(
                  textEditingController: adminNoteController,
                  data: data!,
                  forEventPage: true,
                ),
              ],
            ),
          );
        },
      ),
      //! Tambahkan pengecekan untuk User Member agar bisa menampilkan BottomButtonJoin
      // bottomNavigationBar: (data.adminUsername == 'Admin' || data.adminUsername == 'Superadmin')
      //         ? ButtonAdminUpdateEvent(
      //             changeStatus: _changeStatus,
      //             showEditNoteDialog: _showEditNoteDialog)
    );
  }
}
