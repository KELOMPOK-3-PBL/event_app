import 'package:event_proposal_app/bloc/bloc.dart';
import 'package:event_proposal_app/data/model/model.dart';
import 'package:event_proposal_app/ui/widget/show_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:uicons_pro/uicons_pro.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/ui_colors.dart';

class BodyDetailEvent extends StatelessWidget {
  const BodyDetailEvent({
    super.key,
    required this.textEditingController,
    required this.data,
    required this.forEventPage,
  });

  final TextEditingController textEditingController;
  final EventDataModel data;
  final bool forEventPage;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (forEventPage == false)
              AdminNoteSection(
                adminNoteController: textEditingController,
                adminNote: data.adminNote,
              ),
            MainInfoSection(
              data: data,
              forEventPage: forEventPage,
            ),
            OrganizerSection(data: data),
            if (data.invitedPersons != null && data.invitedPersons!.isNotEmpty)
              InvitedPersonSection(
                invitedPersons: data.invitedPersons,
              ),
            // SizedBox(height: 80),
            SizedBox(height: 8),
            Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 8),
            Text(
              data.description,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarDetailEvent extends StatelessWidget {
  const AppBarDetailEvent({
    super.key,
    required this.data,
    required this.title,
    this.currentRole,
  });

  final EventDataModel data;
  final String title;
  final String? currentRole;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [
        if (currentRole == 'Propose'
            //  || currentRole == 'Superadmin'
            )
          Container(
            margin: EdgeInsets.only(right: 6),
            child: IconButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(UIColor.transparentWhite)),
                color: UIColor.rejected,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Delete ${data.title}",
                            style: TextStyle(
                                color: UIColor.rejected,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          content: Text('Sure, want to delete this event?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: UIColor.typoBlack),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(UIColor.rejected)),
                              onPressed: () {
                                context.read<EventBloc>().add(
                                    EventDeleteData(eventID: data.eventId!));
                              },
                              child: Text(
                                'Confirm',
                                style: TextStyle(color: UIColor.solidWhite),
                              ),
                            )
                          ],
                        );
                      });
                },
                icon: Icon(UIconsPro.solidRounded.trash_check)),
          )
      ],
      shadowColor: UIColor.shadowColor,
      centerTitle: true,
      surfaceTintColor: UIColor.solidWhite,
      elevation: 0,
      // pinned: true,
      expandedHeight: MediaQuery.of(context).size.width /
          1.4, //! Buat tinggi gambar berbanding dengan lebar layar
      leading: IconButton(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(UIColor.transparentWhite)),
        color: UIColor.typoBlack,
        icon: Icon(UIconsPro.regularRounded.angle_small_left),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: UIColor.solidWhite,
      title: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 7, vertical: 4),
        decoration: BoxDecoration(
            color: UIColor.shadowColor,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          title,
          style: TextStyle(
            // backgroundColor: UIColor.solidWhite,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color:
                // _isScrolled ?
                // UIColor.typoBlack,
                // :
                UIColor.solidWhite,
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  backgroundColor: Colors.black,
                  insetPadding: EdgeInsets.all(0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: PhotoView(
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return Image.asset(
                          'assets/images/image_not_found.png',
                          // height: (MediaQuery.of(context).size.width - 44) / 3,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                      imageProvider: NetworkImage(
                          // (data.posterUrl != null)
                          // ?
                          data.posterUrl!
                          // : 'https://i.ibb.co.com/pW4RQff/poster-techomfest.jpg'
                          ),
                      backgroundDecoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 3.0,
                    ),
                  ),
                );
              },
            );
          },
          child: Image.network(
            data.posterUrl!,
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
            height: 250,
            width: double.infinity,
            errorBuilder: (context, object, stackTrace) => Image.asset(
              'assets/images/image_not_found.png',
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}

class InvitedPersonSection extends StatelessWidget {
  const InvitedPersonSection({
    super.key,
    this.invitedPersons,
  });

  final List<InvitedPerson>? invitedPersons;
  // final List<Map<String, String>> invitedPersonsStatis = [
  //   {
  //     "name": "Sofia Trenia",
  //     "image":
  //         "https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
  //   },
  //   {
  //     "name": "Demian",
  //     "image":
  //         "https://cdn.pixabay.com/photo/2016/11/29/06/08/woman-1867715_960_720.jpg"
  //   },
  //   {
  //     "name": "Felix Roudger",
  //     "image":
  //         "https://cdn.pixabay.com/photo/2016/11/29/06/08/woman-1867715_960_720.jpg"
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(vertical: 6),
      decoration: BoxDecoration(
          color: UIColor.solidWhite, borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Invited Person",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          SizedBox(
            height: 10,
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap:
                true, // Agar ListView dapat menyesuaikan tinggi dengan konten di dalamnya
            physics:
                NeverScrollableScrollPhysics(), // Menghindari scrolling di dalam ListView
            itemCount: invitedPersons!.length,
            itemBuilder: (context, index) {
              final person = invitedPersons![index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: UIColor.primary,
                      child: Icon(
                        UIconsPro.regularRounded.user,
                        size: 12,
                        color: UIColor.solidWhite,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      person.username,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: UIColor.typoGray),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class OrganizerSection extends StatelessWidget {
  const OrganizerSection({
    super.key,
    required this.data,
  });

  final EventDataModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: UIColor.solidWhite,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      // margin: EdgeInsets.all(8),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // tileColor: UIColor.solidWhite,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(data.proposeAvatar ?? ''),
            backgroundColor: UIColor.primary,
            child: (data.proposeAvatar == null)
                ? Icon(UIconsPro.regularRounded.user, color: Colors.white)
                : null,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // 'UKM PCC',
                data.proposeUsername ?? 'Unknown User',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text('Organizer', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

class MainInfoSection extends StatelessWidget {
  const MainInfoSection({
    super.key,
    required this.data,
    required this.forEventPage,
  });

  final EventDataModel data;
  final bool forEventPage;

  // Fungsi untuk menampilkan dialog konfirmasi
  Future<bool> showConfirmationDialog(BuildContext context, String url) async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm'),
              content: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'You will be redirected to an external link:\n',
                    ),
                    TextSpan(
                      text: url,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: UIColor.typoBlack),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(color: UIColor.solidWhite),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  // Fungsi untuk membuka URL
  Future<void> launchUrlWithErrorHandling(
      BuildContext context, String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        if (!context.mounted) return;
        final shouldLaunch = await showConfirmationDialog(context, url);
        if (shouldLaunch) {
          await launchUrl(
            uri,
            mode: LaunchMode.externalApplication,
          );
          debugPrint('URL launched successfully');
        }
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
      if (context.mounted) {
        showCustomSnackBar(context, 'Failed to open link: $e');
        // showError(context, 'Gagal membuka link: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(vertical: 6),
      decoration: BoxDecoration(
          color: UIColor.solidWhite, borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (forEventPage == false)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Added: ${data.dateAdd}',
                    style: TextStyle(fontSize: 10, color: UIColor.primary)),
                if (data.updated != null)
                  Text('Updated: ${data.updated}',
                      style: TextStyle(fontSize: 10, color: UIColor.reviewing))
              ],
            ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 4, 0, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${data.category}: ${data.title}',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                if (forEventPage == false)
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: UIColor.getStatusColor(data.status!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 14),
                        child: Text(
                          data.status!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      if (data.adminUsername != null)
                        Text('Checked by: ${data.adminUsername}',
                            style:
                                TextStyle(fontSize: 10, color: UIColor.admin)),
                    ],
                  ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                UIconsPro.regularRounded.user,
                color: UIColor.primary,
                size: 12,
              ),
              SizedBox(width: 8),
              Text('${data.quota} Participants',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
          Row(
            children: [
              Icon(UIconsPro.regularRounded.house_building,
                  color: UIColor.primary, size: 12),
              if (data.location != null) SizedBox(width: 8),
              Text(data.place,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
          Row(
            children: [
              Icon(UIconsPro.regularRounded.marker,
                  color: UIColor.primary, size: 12),
              SizedBox(width: 8),
              Text(data.location!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          Row(
            children: [
              Icon(UIconsPro.regularRounded.calendar,
                  color: UIColor.primary, size: 12),
              SizedBox(width: 8),
              Text(data.dateStart,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          if (data.dateEnd != null || data.dateEnd!.isNotEmpty)
            Row(
              children: [
                Icon(UIconsPro.solidRounded.calendar,
                    color: UIColor.primary, size: 12),
                SizedBox(width: 8),
                Text(
                  data.dateEnd!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          GestureDetector(
            onTap: () async {
              if (data.schedule != null) {
                await launchUrlWithErrorHandling(context, data.schedule!);
              } else {
                showCustomSnackBar(context, 'No Complete Schedule Found');
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: UIColor.admin,
              ),
              margin: EdgeInsets.only(top: 6),
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    size: 14,
                    UIconsPro.solidRounded.time_fast,
                    color: UIColor.solidWhite,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Click to Show Complete Schedule",
                    style: TextStyle(
                      fontSize: 12,
                      color: UIColor.solidWhite,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AdminNoteSection extends StatelessWidget {
  const AdminNoteSection({
    super.key,
    required this.adminNoteController,
    this.adminNote,
  });

  final String? adminNote;

  final TextEditingController adminNoteController;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsetsDirectional.only(bottom: 4),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      decoration: BoxDecoration(
        color: UIColor.solidWhite,
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Admin Note",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
          Text(
            adminNote ?? adminNoteController.text,
            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }
}
