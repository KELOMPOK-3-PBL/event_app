import 'dart:convert';
import 'dart:io';

import 'package:event_proposal_app/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../bloc/event_bloc/event_bloc.dart';
import '../navigation/button_admin_update_event.dart';
import '../navigation/button_propose_update_event.dart';
import '../section/detail_event_content_section.dart';
import '../theme/ui_colors.dart';

class DetailEventApprovalProposeScreen extends StatelessWidget {
  final String currentRole;
  final String eventId;

  const DetailEventApprovalProposeScreen({
    super.key,
    required this.currentRole,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<EventBloc, EventState>(listener: (context, state) {
        if (state is EventUpdated) {
          context.read<EventBloc>().add(EventGetByID(eventId: eventId));
        }
      }, builder: (context, state) {
        debugPrint(state.toString());

        if (state is EventLoaded) {
          return DetailEventApprovalProposeScreenContent(
            currentRole: currentRole,
            eventData: state.eventData,
          );
        }
        return Center(child: CircularProgressIndicator());
      }),
    );
  }
}

class DetailEventApprovalProposeScreenContent extends StatefulWidget {
  final String currentRole;
  final EventDataModel eventData;

  const DetailEventApprovalProposeScreenContent({
    super.key,
    required this.currentRole,
    required this.eventData,
  });

  @override
  State<DetailEventApprovalProposeScreenContent> createState() =>
      _DetailEventApprovalProposeScreenContentState();
}

class _DetailEventApprovalProposeScreenContentState
    extends State<DetailEventApprovalProposeScreenContent> {
  late TextEditingController _adminNoteController;
  final ScreenshotController _screenshotController = ScreenshotController();
  late EventDataModel _currentEventData;

  @override
  void initState() {
    super.initState();
    _adminNoteController =
        TextEditingController(text: widget.eventData.adminNote ?? '-');
    _currentEventData = widget.eventData;
  }

  @override
  void dispose() {
    _adminNoteController.dispose();
    super.dispose();
  }

  Future<void> _changeStatus(BuildContext context) async {
    final newStatus = await showDialog<int>(
      context: context,
      builder: (_) => _buildStatusDialog(),
    );

    if (newStatus != null && context.mounted) {
      _updateEventStatus(context, newStatus);
    }
  }

  AlertDialog _buildStatusDialog() {
    final statusOptions = [
      ('Revision Propose', 2),
      ('Approved', 4),
      ('Rejected', 5),
    ];

    return AlertDialog(
      title: const Text("Change Status"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: statusOptions
            .where((status) =>
                status.$1 !=
                _currentEventData.status) // Filter status yang sama
            .map((status) => _buildStatusOption(status))
            .toList(),
      ),
    );
  }

  Widget _buildStatusOption((String, int) status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: UIColor.getStatusColor(status.$1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        title: Text(
          status.$1,
          textAlign: TextAlign.center,
          style: TextStyle(color: UIColor.solidWhite),
        ),
        onTap: () => Navigator.of(context).pop(status.$2),
      ),
    );
  }

  void _updateEventStatus(BuildContext context, int statusId) {
    final updatedEvent = _currentEventData.copyWith(
      statusID: statusId,
      adminNote: _adminNoteController.text,
    );

    context.read<EventBloc>().add(EventUpdateData(eventData: updatedEvent))
        // ..add(
        //   EventGetByIDRefresh(eventId: updatedEvent.eventId!),
        // )
        ;
  }

  Future<void> _showEditNoteDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => _buildEditNoteDialog(),
    );

    if (result != null && mounted) {
      setState(() => _adminNoteController.text = result);
      _updateEventStatus(context, _currentEventData.statusID!);
    }
  }

  AlertDialog _buildEditNoteDialog() {
    final TextEditingController tempController =
        TextEditingController(text: _adminNoteController.text);

    return AlertDialog(
      title: const Text("Edit Admin Note"),
      content: TextField(
        controller: tempController,
        maxLines: 4,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter new admin note...",
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(tempController.text),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          child: const Text("Save"),
        ),
      ],
    );
  }

  Future<void> _showQR(String eventId) async {
    await showDialog(
      context: context,
      builder: (context) => _buildQRDialog(eventId),
    );
  }

  AlertDialog _buildQRDialog(String eventId) {
    return AlertDialog(
      backgroundColor: UIColor.solidWhite,
      title: const Text("Attendance QR"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Participants are asked to scan to check attendance',
            style: TextStyle(fontSize: 12),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width - 130,
            child: Screenshot(
              controller: _screenshotController,
              child: QrImageView(
                data: base64Encode(utf8.encode(eventId)),
                version: QrVersions.auto,
                backgroundColor: UIColor.solidWhite,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "Close",
            style: TextStyle(color: UIColor.typoBlack),
          ),
        ),
        ElevatedButton(
          onPressed: _downloadQR,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          child: Text(
            "Download",
            style: TextStyle(color: UIColor.solidWhite),
          ),
        ),
      ],
    );
  }

  Future<void> _downloadQR() async {
    try {
      final image = await _screenshotController.capture();
      if (image == null) throw Exception('Failed to capture QR code');

      if (!await _requestStoragePermission()) {
        throw Exception('Storage permission denied');
      }

      final directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final path =
          '${directory.path}/qr_code_${DateTime.now().millisecondsSinceEpoch}.png';
      await File(path).writeAsBytes(image);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('QR Code downloaded to $path')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  Future<bool> _requestStoragePermission() async {
    if (!Platform.isAndroid) return true;

    final status = await Permission.manageExternalStorage.status;
    if (status.isGranted) return true;

    final result = await Permission.manageExternalStorage.request();
    if (result.isGranted) return true;

    return await Permission.storage.request().isGranted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColor.white,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<EventBloc>().add(
                EventGetByID(eventId: _currentEventData.eventId!),
              );
        },
        child: CustomScrollView(
          slivers: [
            AppBarDetailEvent(
              data: _currentEventData,
              title: 'Review Event',
            ),
            BodyDetailEvent(
              textEditingController: _adminNoteController,
              data: _currentEventData,
              forEventPage: false,
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return widget.currentRole == 'Propose'
        ? ButtonProposeUpdateEvent(
            showQR: () => _showQR(_currentEventData.eventId!),
            changeStatus: () => _changeStatus(context),
            showEditNoteDialog: _showEditNoteDialog,
          )
        : ButtonAdminUpdateEvent(
            changeStatus: () => _changeStatus(context),
            showEditNoteDialog: _showEditNoteDialog,
          );
  }
}
