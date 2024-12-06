import 'package:event_proposal_app/data/model/model.dart';
import 'package:event_proposal_app/ui/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uicons_pro/uicons_pro.dart';

import '../../bloc/user_bloc/user_bloc.dart';
import '../section/detail_profile_content_section.dart';
import '../theme/ui_colors.dart';

class HomeProfilePage extends StatefulWidget {
  const HomeProfilePage({super.key});

  @override
  State<HomeProfilePage> createState() => _HomeProfilePageState();
}

class _HomeProfilePageState extends State<HomeProfilePage> {
  UserDataModel? userData;

  @override
  void initState() {
    super.initState;

    final state = context.read<UserBloc>().state;
    if (state is UserByUIDLoaded) {
      userData = state.userData;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileAppBar(userData: userData),
        Expanded(
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserByUIDLoaded) {
                userData = state.userData;
                return DetailProfileContentSection(userData: userData);
              } else if (state is UserLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Center(
                child: Text("User Not Found"),
                // child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    super.key,
    this.userData,
  });

  final UserDataModel? userData;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: UIColor.shadowColor,
      actions: [
        IconButton(
          icon: Icon(
            UIconsPro.regularRounded.settings,
            size: 17,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(
              AppRouter.settingsRoute,
            );
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
    );
  }
}
