import 'package:event_proposal_app/data/model/model.dart';
import 'package:flutter/material.dart';

import '../navigation/bottom_button_approval.dart';
import '../section/detail_event_content_section.dart';
import '../theme/ui_colors.dart';

class DetailEventApprovalScreen extends StatefulWidget {
  final EventDataModel data;
  const DetailEventApprovalScreen({super.key, required this.data});

  @override
  DetailEventApprovalScreenState createState() =>
      DetailEventApprovalScreenState();
}

class DetailEventApprovalScreenState extends State<DetailEventApprovalScreen> {
  TextEditingController adminNoteController = TextEditingController(text: '-');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Fungsi untuk mengubah status
  void _changeStatus() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Change Status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Proposed"),
                onTap: () {
                  // setState(() {
                  //   status = "Proposed";
                  //   _updateStatusColor();
                  // });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text("Pending"),
                onTap: () {
                  // setState(() {
                  //   status = "Pending";
                  //   _updateStatusColor();
                  // });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text("Approved"),
                onTap: () {
                  // setState(() {
                  //   status = "Approved";
                  //   _updateStatusColor();
                  // });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text("Rejected"),
                onTap: () {
                  // setState(() {
                  //   status = "Rejected";
                  //   _updateStatusColor();
                  // });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Fungsi untuk menampilkan dialog pengeditan
  void _showEditNoteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Admin Note"),
          content: TextField(
            controller: adminNoteController,
            maxLines: 4,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter new admin note...",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Update admin note dengan teks baru dari controller
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text("Save"),
            ),
          ],
        );
      },
    );
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
            title: 'Review Event',
          ),
          BodyDetailEvent(
            textEditingController: adminNoteController,
            data: data,
            forEventPage: false,
          ),
        ],
      ),
      bottomNavigationBar: BottomButtonApproval(
          changeStatus: _changeStatus, showEditNoteDialog: _showEditNoteDialog),
    );
  }
}
