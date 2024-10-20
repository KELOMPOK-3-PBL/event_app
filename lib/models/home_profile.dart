// import 'package:event_proposal_app/models/search_events.dart';
import 'package:event_proposal_app/models/ui_colors.dart';
// import 'package:intl/intl.dart';
// import 'package:uicons_pro/uicons_pro.dart';
import 'package:flutter/material.dart';

class HomeProfile extends StatefulWidget {
  const HomeProfile({super.key});

  @override
  State<HomeProfile> createState() => _HomeProfile();
}

class _HomeProfile extends State<HomeProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AppBar(
        automaticallyImplyLeading: false, // remove leading(left) back icon
        centerTitle: true,
        backgroundColor: UIColor.solidWhite,
        scrolledUnderElevation: 0,
        title: Text(
          "My Profile",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: UIColor.typoBlack,
          ),
        ),
      ),
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Elemen lain tetap di tengah
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 60, // Atur ukuran lingkaran di sini
                backgroundColor: Colors.grey[300],
                backgroundImage: NetworkImage(
                    'images/fotopf.png'), // Ganti dengan URL gambar Anda
              ),
              SizedBox(height: 16),
              Text(
                'Atsilla Arya',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),

              // Bagian "About Me" dan "Interests" rata kiri
              Align(
                alignment: Alignment.centerLeft, // Rata kiri
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                  children: [
                    // Section "About Me"
                    Text(
                      'About Me',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'I am a student with a strong interest in mobile app development, '
                      'UI/UX design, and gaming. I also enjoy competing in the fields '
                      'of technology and design, constantly striving to improve my skills.',
                      textAlign: TextAlign.left, // Teks rata kiri
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Read More',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(height: 24),

                    // Section "Interests"
                    Text(
                      'Interests',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        InterestChip(label: 'Music'),
                        InterestChip(label: 'Workshop'),
                        InterestChip(label: 'Art'),
                        InterestChip(label: 'Sport'),
                        InterestChip(label: 'Food'),
                        InterestChip(label: 'Seminar'),
                        InterestChip(label: 'E-Sport'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}

class InterestChip extends StatelessWidget {
  final String label;

  InterestChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue, // Warna biru sesuai permintaan
    );
  }
}
