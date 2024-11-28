import 'package:event_proposal_app/data/model/model.dart';
import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:uicons_pro/uicons_pro.dart';
import 'package:url_launcher/url_launcher.dart';

import '../navigation/bottom_button_approval.dart';
import '../theme/ui_colors.dart';

class DetailEventApprovalScreen extends StatefulWidget {
  final EventDataModel data;
  const DetailEventApprovalScreen({super.key, required this.data});

  @override
  DetailEventApprovalScreenState createState() =>
      DetailEventApprovalScreenState();
}

class DetailEventApprovalScreenState extends State<DetailEventApprovalScreen> {
  String eventTitle = 'Seminar : Techcomfest';
  String attendees = '120 Person';
  String location = 'GKT VIII/05';
  String city = 'Semarang, Indonesia';
  String dateRange = '23 - 25 July 2023';
  // String time = '08:00 - end';
  String timeStamp = 'Added: 12/12/2024 08:00';
  String status = "Proposed";
  Color statusColor = UIColor.propose;

  String description =
      'Join us at Techomfest, the ultimate seminar for tech enthusiasts, innovators, and future leaders! '
      'This year’s seminar will dive deep into the latest advancements in technology, from artificial intelligence '
      'and blockchain to the Internet of Things (IoT) and cutting-edge software development.'
      'Join us at Techomfest, the ultimate seminar for tech enthusiasts, innovators, and future leaders! '
      'This year’s seminar will dive deep into the latest advancements in technology, from artificial intelligence '
      'and blockchain to the Internet of Things (IoT) and cutting-edge software development.'
      'Join us at Techomfest, the ultimate seminar for tech enthusiasts, innovators, and future leaders! '
      'This year’s seminar will dive deep into the latest advancements in technology, from artificial intelligence '
      'and blockchain to the Internet of Things (IoT) and cutting-edge software development.'
      'Join us at Techomfest, the ultimate seminar for tech enthusiasts, innovators, and future leaders! '
      'This year’s seminar will dive deep into the latest advancements in technology, from artificial intelligence '
      'and blockchain to the Internet of Things (IoT) and cutting-edge software development.';

  List<Map<String, String>> invitedPersons = [
    {
      "name": "Sofia Trenia",
      "image":
          "https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    },
    {
      "name": "Demian",
      "image":
          "https://cdn.pixabay.com/photo/2016/11/29/06/08/woman-1867715_960_720.jpg"
    },
    {
      "name": "Felix Roudger",
      "image":
          "https://cdn.pixabay.com/photo/2016/11/29/06/08/woman-1867715_960_720.jpg"
    },
  ];

  TextEditingController adminNoteController = TextEditingController(text: '-');

  // Fungsi untuk memperbarui warna berdasarkan status
  void _updateStatusColor() {
    if (status == "Proposed") {
      statusColor = UIColor.propose;
    } else if (status == "Pending") {
      statusColor = UIColor.pending;
    } else if (status == "Approved") {
      statusColor = UIColor.approved;
    } else {
      statusColor = UIColor.rejected;
    }
  }

  // late ScrollController _scrollController;
  // bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    // _scrollController = ScrollController();
    // _scrollController.addListener(() {
    //   if (_scrollController.hasClients) {
    //     final isScrolled = _scrollController.offset > 200;
    //     if (isScrolled != _isScrolled) {
    //       setState(() {
    //         _isScrolled = isScrolled;
    //       });
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    // _scrollController.removeListener(_scrollListener);
    // _scrollController.dispose();
    super.dispose();
  }

  // void _scrollListener() {
  //   if (_scrollController.offset > 200 && !_isScrolled) {
  //     setState(() {
  //       _isScrolled = true;
  //     });
  //   } else if (_scrollController.offset <= 200 && _isScrolled) {
  //     setState(() {
  //       _isScrolled = false;
  //     });
  //   }
  // }

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
                  setState(() {
                    status = "Proposed";
                    _updateStatusColor();
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text("Pending"),
                onTap: () {
                  setState(() {
                    status = "Pending";
                    _updateStatusColor();
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text("Approved"),
                onTap: () {
                  setState(() {
                    status = "Approved";
                    _updateStatusColor();
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text("Rejected"),
                onTap: () {
                  setState(() {
                    status = "Rejected";
                    _updateStatusColor();
                  });
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

    String eventTitle = data.title;
    String attendees = data.quota;
    String location = data.location!;
    String city = data.place;
    String dateRange = data.dateEnd!;
    // String time = data.dateStart;
    String timeStamp = data.dateAdd;
    String status = data.status;
    Color statusColor = UIColor.getStatusColor(data.status);

    String description = data.description;

    return Scaffold(
      backgroundColor: UIColor.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            surfaceTintColor: UIColor.solidWhite,
            elevation: 0,
            // pinned: true,
            expandedHeight: MediaQuery.of(context).size.width /
                1.4, //! Buat tinggi gambar berbanding dengan lebar layar
            leading: IconButton(
              color:
                  // _isScrolled ?
                  // UIColor.typoBlack,
                  // :
                  UIColor.solidWhite,
              icon: Icon(UIconsPro.regularRounded.angle_small_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: UIColor.solidWhite,
            title: Text(
              "Review Events",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:
                    // _isScrolled ?
                    // UIColor.typoBlack,
                    // :
                    UIColor.solidWhite,
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
                    data.posterUrl!,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w800)),
                        Text(
                          adminNoteController.text,
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[800]),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                        color: UIColor.solidWhite,
                        borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Added: $timeStamp',
                                style: TextStyle(
                                    fontSize: 10, color: UIColor.primary)),
                            Text('Updated: ${data.updated}',
                                style: TextStyle(
                                    fontSize: 10, color: UIColor.reviewing)),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 4, 0, 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${data.category}: $eventTitle',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800)),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      color: statusColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 14),
                                    child: Text(
                                      status,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Text('Checked by: ${data.adminUsername}',
                                      style: TextStyle(
                                          fontSize: 10, color: UIColor.admin)),
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
                            Text('$attendees Person',
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
                            SizedBox(width: 8),
                            Text(location,
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
                            Text(city,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(UIconsPro.regularRounded.calendar,
                                    color: UIColor.primary, size: 12),
                                SizedBox(width: 8),
                                Text(dateRange,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            // Row(
                            //   children: [
                            //     Icon(UIconsPro.regularRounded.clock,
                            //         color: UIColor.primary, size: 12),
                            //     SizedBox(width: 8),
                            //     Text(
                            //       time,
                            //       style: TextStyle(
                            //         fontSize: 12,
                            //         fontWeight: FontWeight.w500,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            // if (data.schedule != null &&
                            //     data.schedule!.isNotEmpty) {
                            String url = data.schedule ??
                                'https://docs.google.com/spreadsheets/d/1vR7XZabWPs9qMRtg8btOZWlaF32O7gjlZONN6C2Q-98/edit?gid=1854995311#gid=1854995311';
                            debugPrint('Attempting to launch URL: $url');
                            try {
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(
                                  Uri.parse(url),
                                  mode: LaunchMode.externalApplication,
                                );
                                debugPrint('URL launched successfully');
                              } else {
                                debugPrint('Could not launch URL: $url');
                                throw 'Could not launch $url';
                              }
                            } catch (e) {
                              debugPrint('Error launching URL: $e');
                            }
                            // } else {
                            //   debugPrint('URL is null or empty');
                            // }
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
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: UIColor.solidWhite,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    // margin: EdgeInsets.all(8),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // tileColor: UIColor.solidWhite,
                      children: [
                        CircleAvatar(
                          backgroundColor: UIColor.primary,
                          child: Icon(UIconsPro.regularRounded.user,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'UKM PCC',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text('Organizer',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                        color: UIColor.solidWhite,
                        borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Invited Person",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap:
                              true, // Agar ListView dapat menyesuaikan tinggi dengan konten di dalamnya
                          physics:
                              NeverScrollableScrollPhysics(), // Menghindari scrolling di dalam ListView
                          itemCount: invitedPersons.length,
                          itemBuilder: (context, index) {
                            final person = invitedPersons[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundImage: NetworkImage(
                                        person["image"].toString()),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    person["name"]!,
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
                    description,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomButtonApproval(
          changeStatus: _changeStatus, showEditNoteDialog: _showEditNoteDialog),
    );
  }
}
