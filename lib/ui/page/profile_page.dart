import 'package:event_proposal_app/data/model/model.dart';
import 'package:event_proposal_app/ui/router/router.dart';
import 'package:event_proposal_app/ui/theme/ui_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uicons_pro/uicons_pro.dart';

import '../../bloc/user_bloc/user_bloc.dart';

class HomeProfilePage extends StatefulWidget {
  const HomeProfilePage({super.key});

  @override
  State<HomeProfilePage> createState() => _HomeProfile();
}

class _HomeProfile extends State<HomeProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserByUIDLoaded) {
          return ProfilePage(userData: state.userData);
        }
        return ProfilePage();
      },
    );
  }
}

class ProfilePage extends StatelessWidget {
  final UserDataModel? userData;
  const ProfilePage({
    super.key,
    this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AppBar(
        actions: [
          IconButton(
            icon: Icon(
              UIconsPro.regularRounded.settings,
              size: 17,
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.settingsRoute,
                  arguments: userData);
            },
          ),
        ],
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
                backgroundImage: NetworkImage(userData?.avatar ??
                    'https://img.freepik.com/free-vector/illustration-businessman_53876-5856.jpg?t=st=1729955954~exp=1729959554~hmac=21f4e9f848ed4521b47e6041fcd202d019651577ec676e23bba8e7fe93adce16&w=826'), // Ganti dengan URL gambar Anda
              ),

              SizedBox(height: 16),
              Text(
                // 'Fattur Fadhika',
                userData?.username ?? 'Tidak Ada Data',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 6, bottom: 30),
                height: 24,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: userData!.roles.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: UIColor.getRoleColor(userData!.roles[index]),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          userData!.roles[index],
                          style: const TextStyle(
                            color: UIColor.solidWhite,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

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
                      userData?.about ??
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
                    // TextButton(
                    //   onPressed: () {},
                    //   child: Text(
                    //     'Read More',
                    //     style: TextStyle(
                    //       color: Colors.blue,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 24),

                    // Section "Interests"
                    // Text(
                    //   'Interests',
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // SizedBox(height: 16),
                    // Wrap(
                    //   spacing: 8.0,
                    //   runSpacing: 8.0,
                    //   children: [
                    //     InterestChip(label: 'Music'),
                    //     InterestChip(label: 'Workshop'),
                    //     InterestChip(label: 'Art'),
                    //     InterestChip(label: 'Sport'),
                    //     InterestChip(label: 'Food'),
                    //     InterestChip(label: 'Seminar'),
                    //     InterestChip(label: 'E-Sport'),
                    //   ],
                    // ),
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

  const InterestChip({super.key, required this.label});

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
