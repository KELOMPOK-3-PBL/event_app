import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:uicons_pro/uicons_pro.dart';

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
      home: DetailEventScreen(),
      debugShowCheckedModeBanner: false, // Debug banner removed
    );
  }
}

class DetailEventScreen extends StatefulWidget {
  const DetailEventScreen({super.key});

  @override
  DetailEventScreenState createState() => DetailEventScreenState();
}

class DetailEventScreenState extends State<DetailEventScreen> {
  final String eventTitle = 'Seminar : Techcomfest';
  final String location = 'Gedung Kuliah Terpadu Lantai 2';
  final String dateTime = '12 Januari 2024 - 10:00 PM';
  final int totalTickets = 50;
  final String description =
      'Join us at Techomfest, the ultimate seminar for tech enthusiasts, innovators, and future leaders! '
      'This year’s seminar will dive deep into the latest advancements in technology, from artificial intelligence '
      'and blockchain to the Internet of Things (IoT) and cutting-edge software development.';

  final String fullDescription =
      'With renowned speakers, interactive panels, and hands-on workshops, Techomfest offers a unique opportunity to explore '
      'how technology is shaping the future across various industries. Whether you\'re a student, entrepreneur, or tech professional, '
      'this event is your gateway to new knowledge and innovation.';

  final int availableTickets = 44;

  bool isLoved = false; // State for love button interaction

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  backgroundColor: Colors
                                      .black, // Background hitam untuk tampilan full image
                                  insetPadding: EdgeInsets.all(
                                      0), // Hilangkan padding di dialog
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pop(); // Tutup dialog saat gambar di-tap lagi
                                    },
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: PhotoView(
                                        imageProvider: NetworkImage(
                                            'https://i.ibb.co.com/pW4RQff/poster-techomfest.jpg'),
                                        backgroundDecoration: BoxDecoration(
                                          color: Colors
                                              .black, // Latar belakang hitam saat full screen
                                        ),
                                        minScale: PhotoViewComputedScale
                                            .contained, // Gambar di-fit sesuai layar
                                        maxScale:
                                            PhotoViewComputedScale.covered *
                                                3.0, // Bisa di-zoom hingga 3x
                                      ),
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
                      ],
                    ),
                    // child: Stack(
                    //   children: [
                    //     Image.asset(
                    //       'assets/images/Image_Here.png',
                    //       fit: BoxFit.cover,
                    //       height: 300,
                    //       width: double.infinity,
                    //     ),
                    //     // Container(
                    //     //   decoration: BoxDecoration(
                    //     //     gradient: LinearGradient(
                    //     //       begin: Alignment.topCenter,
                    //     //       end: Alignment.bottomCenter,
                    //     //       colors: [
                    //     //         Colors.black.withOpacity(0.6),
                    //     //         Colors.transparent,
                    //     //       ],
                    //     //     ),
                    //     //   ),
                    //     // ),
                    //   ],
                    // ),
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0), // Updated padding(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Detail seminar
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              eventTitle,
                              style: TextStyle(
                                fontSize: 20, // Title font size updated
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isLoved ? Icons.favorite : Icons.favorite_border,
                              color: isLoved ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                isLoved = !isLoved; // Toggle love interaction
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(UIconsPro.regularRounded.marker,
                              size: 16, color: primaryColor),
                          SizedBox(width: 8),
                          Text(
                            location,
                            style: TextStyle(
                              fontFamily: 'Inter', // Set font to Inter
                              fontSize: 14, // Set font size to 13
                              fontWeight:
                                  FontWeight.w500, // Medium weight (w500)
                              color:
                                  Colors.grey[600], // Optionally set text color
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(UIconsPro.regularRounded.calendar,
                              size: 16, color: primaryColor),
                          SizedBox(width: 8),
                          Text(
                            dateTime,
                            style: TextStyle(
                              fontFamily: 'Inter', // Set font to Inter
                              fontSize: 14, // Set font size to 13
                              fontWeight:
                                  FontWeight.w500, // Medium weight (w500)
                              color:
                                  Colors.grey[600], // Optionally set text color
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(UIconsPro.regularRounded.ticket,
                              size: 16, color: primaryColor),
                          SizedBox(width: 8),
                          Text(
                            '$totalTickets Ticket',
                            style: TextStyle(
                              fontFamily: 'Inter', // Set font to Inter
                              fontSize: 14, // Set font size to 13
                              fontWeight:
                                  FontWeight.w500, // Medium weight (w500)
                              color:
                                  Colors.grey[600], // Optionally set text color
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 8),

                      Divider(color: Colors.grey[300], thickness: 1),

                      // Organizer Info
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: primaryColor,
                            radius: 20,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'UKM PCC',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              Text(
                                'Organizer',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Divider(color: Colors.grey[300], thickness: 1),
                      SizedBox(height: 8),

                      // Descriptions
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
                      SizedBox(height: 8),
                      Text(
                        fullDescription,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700]),
                      ),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Custom AppBar dengan tombol Back, Title, dan Share
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
                      onPressed: () {
                        // Aksi tombol back
                      },
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

          // Bagian bawah dengan tombol "Join"
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              color: Colors.white,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Free',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFAAD14),
                        ),
                      ),
                      Text(
                        '$availableTickets Tickets Left',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Rounded rectangle background with 20% opacity
                      Container(
                        width: 200,
                        height: 60,
                        decoration: BoxDecoration(
                          // color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Aksi ketika tombol join diklik
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              primaryColor, // Use primary blue color
                          minimumSize: Size(200, 60), // Updated button size
                        ),
                        child: Text(
                          'Join',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
