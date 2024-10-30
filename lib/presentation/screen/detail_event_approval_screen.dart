import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:uicons_pro/uicons_pro.dart';
import '../widget/ui_colors.dart';

// Define primary color
const Color primaryColor = Color(0xFF1886EA);
const Color secondaryColor = Color(0xFFFAAD14);

class DetailEventApprovalScreen extends StatefulWidget {
  const DetailEventApprovalScreen({super.key});

  @override
  DetailEventApprovalScreenState createState() =>
      DetailEventApprovalScreenState();
}

class DetailEventApprovalScreenState extends State<DetailEventApprovalScreen> {
  final String eventTitle = 'Seminar : Techcomfest';
  final String attendees = '120 Person';
  final String location = 'GKT VIII/05';
  final String city = 'Semarang, Indonesia';
  final String dateRange = '23 - 25 July 2023';
  final String time = '08:00 - end';
  final String timeStamp = 'Added: 12/12/2024 08:00';
  String status = "Proposed";
  Color statusColor = UIColor.propose;

  final String description =
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

  final List<Map<String, String>> invitedPersons = [
    {"name": "Sofia Trenia", "image": "assets/sofia.png"},
    {"name": "Demian", "image": "assets/demian.jpg"},
    {"name": "Felix Roudger", "image": "assets/felix.jpg"},
  ];

  TextEditingController _adminNoteController = TextEditingController(text: '-');

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
            controller: _adminNoteController,
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
    return Scaffold(
      backgroundColor: UIColor.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            surfaceTintColor: UIColor.solidWhite,
            elevation: 0,
            pinned: true,
            expandedHeight: 400,
            leading: IconButton(
              color:
                  // _isScrolled ?
                  UIColor.typoBlack,
              // : UIColor.solidWhite,
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
                    UIColor.typoBlack,
                // : UIColor.solidWhite,
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
                                'https://i.ibb.co.com/pW4RQff/poster-techomfest.jpg'),
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
                  'https://i.ibb.co.com/pW4RQff/poster-techomfest.jpg',
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                  height: 300,
                  width: double.infinity,
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
                          _adminNoteController.text,
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
                            Text(timeStamp,
                                style: TextStyle(
                                    fontSize: 10, color: UIColor.primary)),
                            Text('Updated: 12/12/2024 08:00',
                                style: TextStyle(
                                    fontSize: 10, color: UIColor.pending)),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 4, 0, 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(eventTitle,
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
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Text('Checked by: Sofia Trenia',
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
                            Text(attendees,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(UIconsPro.regularRounded.marker,
                                color: UIColor.primary, size: 12),
                            SizedBox(width: 8),
                            Text(location,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(UIconsPro.regularRounded.calendar,
                                color: UIColor.primary, size: 12),
                            SizedBox(width: 8),
                            Text(dateRange,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(UIconsPro.regularRounded.clock,
                                color: UIColor.primary, size: 12),
                            SizedBox(width: 8),
                            Text(time,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                )),
                          ],
                        ),
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
                                    backgroundImage:
                                        AssetImage(person["image"].toString()),
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
      bottomNavigationBar: Container(
        color: UIColor.solidWhite,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: ElevatedButton(
                onPressed: _changeStatus,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      UIconsPro.regularRounded.key,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Change Status",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: UIColor.solidWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 4,
              child: ElevatedButton(
                onPressed: _showEditNoteDialog,
                style:
                    ElevatedButton.styleFrom(backgroundColor: secondaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      UIconsPro.regularRounded.edit,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Edit Note",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: UIColor.solidWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
