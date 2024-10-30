import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:uicons_pro/uicons_pro.dart';
import '../widget/ui_colors.dart';

// import 'package:google_fonts/google_fonts.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Make the status bar transparent
    systemNavigationBarColor:
        Colors.transparent, // Make the navigation bar transparent
    // statusBarIconBrightness:
    //     Brightness.dark, // Change icon brightness (optional)
  ));
  runApp(PoliventApp());
}

// Define primary color
const Color primaryColor = Color(0xFF1886EA);
const Color secondaryColor = Color(0xFFFAAD14);

class PoliventApp extends StatelessWidget {
  const PoliventApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Polivent App - Detail Event',
      theme: ThemeData(
        fontFamily: 'Inter', // Set Inter as default font
        primaryColor: primaryColor, // Use primaryColor globally
      ),
      home: DetailEventApprovalScreen(),
      debugShowCheckedModeBanner: false, // Debug banner removed
    );
  }
}

class DetailEventApprovalScreen extends StatefulWidget {
  const DetailEventApprovalScreen({super.key});

  @override
  DetailEventScreenState createState() => DetailEventScreenState();
}

class DetailEventScreenState extends State<DetailEventApprovalScreen> {
  final String eventTitle = 'Seminar : Techcomfest';
  final String attendees = '120 orang';
  final String location = 'Gedung Kuliah Terpadu Lantai 2';
  final String dateTime = '12 January 2024 - 10:00 PM';
  final String timeStamp = '22 December 2023 - 8:00 PM';
  final int totalTickets = 50;
  final String description =
      'Join us at Techomfest, the ultimate seminar for tech enthusiasts, innovators, and future leaders!';
  final String fullDescription =
      'With renowned speakers, interactive panels, and hands-on workshops, Techomfest offers a unique opportunity...';
  String status = "Proposed";
  Color statusColor = UIColor.propose;

  final List<Map<String, String>> invitedPersons = [
    {"name": "Sofia Trenia", "image": "assets/sofia.png"},
    {"name": "Demian", "image": "assets/demian.jpg"},
    {"name": "Felix Roudger", "image": "assets/felix.jpg"},
  ];

  TextEditingController _adminNoteController = TextEditingController(
    text: 'Lorem ipsum dolor sit amet...',
  );

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar di bagian atas dengan rounded corner dan gradient hitam
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: GestureDetector(
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
                                  maxScale:
                                      PhotoViewComputedScale.covered * 3.0,
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Admin Note",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800)),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Text(
                          _adminNoteController.text,
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[800]),
                        ),
                      ),
                      Text("Added date : $timeStamp",
                          style:
                              TextStyle(fontSize: 12, color: UIColor.primary)),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Text(eventTitle,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            child: Text(
                              status,
                              style: TextStyle(
                                  color: UIColor.solidWhite,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      Row(children: [
                        Icon(Icons.people_outlined, color: primaryColor),
                        SizedBox(width: 8),
                        Text(attendees)
                      ]),
                      Row(children: [
                        Icon(Icons.place_outlined, color: primaryColor),
                        SizedBox(width: 8),
                        Text(location)
                      ]),
                      Row(children: [
                        Icon(Icons.event_outlined, color: primaryColor),
                        SizedBox(width: 8),
                        Text(dateTime)
                      ]),
                      Divider(color: Colors.grey[300]),
                      Row(
                        children: [
                          CircleAvatar(
                              backgroundColor: primaryColor,
                              radius: 20,
                              child: Icon(Icons.person, color: Colors.white)),
                          SizedBox(width: 12),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('UKM PCC'),
                                Text('Organizer',
                                    style: TextStyle(color: Colors.grey))
                              ]),
                        ],
                      ),
                      Divider(color: Colors.grey[300]),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Invited Person",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      Column(
                        children: invitedPersons.map((person) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(person["image"]!)),
                            title: Text(person["name"]!,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[800])),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0, // Fixed position at top
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 48, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Row(
                children: [
                  // Back button with semi-transparent background
                  Container(
                    width: 40, // Set width of the container
                    height: 40, // Set height of the container
                    decoration: BoxDecoration(
                      // color: Colors.white
                      //     .withOpacity(0.2), // Semi-transparent background
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Spacer(),
                  // Title "Detail Event" in the center
                  Text(
                    'Detail Event',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Colors.white,
                      fontSize: 20, // Font size 20 as per image
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  // Share button with semi-transparent background
                  Container(
                    width: 40, // Set width of the container
                    height: 40, // Set height of the container
                    decoration: BoxDecoration(
                      // color: Colors.white
                      //     .withOpacity(0.2), // Semi-transparent background
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: Icon(
                        UIconsPro.regularRounded.share,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () {
                        // Aksi tombol share
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _changeStatus,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        minimumSize: Size(100, 40)),
                    child: Row(children: [
                      Icon(Icons.update, size: 18, color: Colors.white),
                      SizedBox(width: 2),
                      Text('Change Status')
                    ]),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _showEditNoteDialog,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: Size(100, 40)),
                    child: Row(children: [
                      Icon(Icons.edit_note, size: 18, color: Colors.white),
                      SizedBox(width: 2),
                      Text('Edit Note')
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
}
