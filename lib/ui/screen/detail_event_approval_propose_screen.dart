import 'package:event_proposal_app/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../bloc/event_bloc/event_bloc.dart';
import '../navigation/button_admin_update_event.dart';
import '../navigation/button_propose_update_event.dart';
import '../section/detail_event_content_section.dart';
import '../theme/ui_colors.dart';

class DetailEventApprovalProposeScreen extends StatefulWidget {
  final EventDataModel eventData;
  final String currentRole;
  final String token;
  const DetailEventApprovalProposeScreen({
    super.key,
    required this.token,
    required this.eventData,
    required this.currentRole,
  });

  @override
  DetailEventApprovalProposeScreenState createState() =>
      DetailEventApprovalProposeScreenState();
}

class DetailEventApprovalProposeScreenState
    extends State<DetailEventApprovalProposeScreen> {
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
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  color: UIColor.getStatusColor('Pending'),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  title: Text(
                    "Pending",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: UIColor.solidWhite,
                    ),
                  ),
                  onTap: () {
                    // setState(() {
                    //   status = "Pending";
                    //   _updateStatusColor();
                    // });
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  color: UIColor.getStatusColor('Approved'),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  title: Text(
                    "Approved",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: UIColor.solidWhite,
                    ),
                  ),
                  onTap: () {
                    // setState(() {
                    //   status = "Proposed";
                    //   _updateStatusColor();
                    // });
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  color: UIColor.getStatusColor('Rejected'),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  title: Text(
                    "Rejected",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: UIColor.solidWhite,
                    ),
                  ),
                  onTap: () {
                    // setState(() {
                    //   status = "Pending";
                    //   _updateStatusColor();
                    // });
                    Navigator.of(context).pop();
                  },
                ),
              ),
              // ListTile(
              //   title: Text("Approved"),
              //   onTap: () {
              //     // setState(() {
              //     //   status = "Approved";
              //     //   _updateStatusColor();
              //     // });
              //     Navigator.of(context).pop();
              //   },
              // ),
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

  // Fungsi untuk menampilkan QR
  // Fungsi untuk menampilkan QR
  void _showQR(String eventId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Attendance QR"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Participants are asked to scan to check attendance',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 10),
              Center(
                child: QrImageView(
                  data: eventId,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
            ElevatedButton(
              onPressed: () {
                // Tambahkan fungsi download QR di sini
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text("Download"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    EventDataModel? data = widget.eventData;

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
                  title: 'Review Event',
                ),
                BodyDetailEvent(
                  textEditingController: adminNoteController,
                  data: data!,
                  forEventPage: false,
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: (widget.currentRole == 'Propose')
          ? ButtonProposeUpdateEvent(
              showQR: () {
                _showQR(data!.eventId!);
              },
              changeStatus: _changeStatus,
              showEditNoteDialog: _showEditNoteDialog)
          : ButtonAdminUpdateEvent(
              changeStatus: _changeStatus,
              showEditNoteDialog: _showEditNoteDialog),
    );
  }
}
