import 'package:event_proposal_app/ui/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uicons_pro/uicons_pro.dart';

import '../../bloc/user_bloc/user_bloc.dart';
import '../section/detail_profile_content.dart';
import '../theme/ui_colors.dart';

class HomeProfilePage extends StatelessWidget {
  const HomeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserByUIDLoaded) {
          return Column(
            children: [
              AppBar(
                actions: [
                  IconButton(
                    icon: Icon(
                      UIconsPro.regularRounded.settings,
                      size: 17,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouter.settingsRoute,
                          arguments: state.userData);
                    },
                  ),
                ],
                automaticallyImplyLeading:
                    false, // remove leading(left) back icon
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
              DetailProfileContent(userData: state.userData),
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
