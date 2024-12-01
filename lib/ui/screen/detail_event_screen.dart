import 'package:event_proposal_app/data/model/model.dart';
import 'package:event_proposal_app/ui/section/detail_event_content_section.dart';
import 'package:flutter/material.dart';

// import '../navigation/bottom_button_approval.dart';
import '../theme/ui_colors.dart';

class DetailEventScreen extends StatefulWidget {
  final EventDataModel data;
  const DetailEventScreen({super.key, required this.data});

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
    final data = widget.data;

    return Scaffold(
      backgroundColor: UIColor.white,
      body: CustomScrollView(
        slivers: [
          AppBarDetailEvent(
            data: data,
            title: 'Detail Event',
          ),
          BodyDetailEvent(
            textEditingController: adminNoteController,
            data: data,
            forEventPage: true,
          ),
        ],
      ),
      //! Tambahkan pengecekan untuk User Member agar bisa menampilkan BottomButtonJoin
      // bottomNavigationBar: BottomButtonApproval(
      //     changeStatus: _changeStatus, showEditNoteDialog: _showEditNoteDialog),
    );
  }
}
