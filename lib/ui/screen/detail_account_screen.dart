import 'package:event_proposal_app/ui/section/detail_profile_content.dart';
import 'package:event_proposal_app/ui/theme/ui_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uicons_pro/uicons_pro.dart';

import '../../bloc/user_bloc/user_bloc.dart';
import '../navigation/bottom_button_update_rbac.dart';

class DetailAccountScreen extends StatefulWidget {
  const DetailAccountScreen({super.key});

  @override
  State<DetailAccountScreen> createState() => _HomeProfile();
}

class _HomeProfile extends State<DetailAccountScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColor.white,
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserByUIDLoaded) {
            return Column(
              children: [
                AppBar(
                  leading: IconButton(
                    icon: Icon(
                      UIconsPro.regularRounded.angle_small_left,
                      size: 17,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  automaticallyImplyLeading:
                      false, // remove leading(left) back icon
                  centerTitle: true,
                  backgroundColor: UIColor.solidWhite,
                  scrolledUnderElevation: 0,
                  title: Text(
                    "Account Profile",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: UIColor.typoBlack,
                    ),
                  ),
                ),
                DetailProfileContent(userData: state.userData),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: BottomButtonUpdateRBAC(
        changeStatus: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog();
              });
        },
      ),
    );
  }
}
