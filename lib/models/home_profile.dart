// import 'package:event_proposal_app/models/search_events.dart';
import 'package:event_proposal_app/models/ui_colors.dart';
import 'package:intl/intl.dart';
import 'package:uicons_pro/uicons_pro.dart';
import 'package:flutter/material.dart';

class HomeProfile extends StatefulWidget {
  const HomeProfile({super.key});

  @override
  State<HomeProfile> createState() => _HomeProfile();
}

class _HomeProfile extends State<HomeProfile> {
  late List<Profie> _profile;

  @override
  void initState() {
    super.initState();
    _profile = getAccount();
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
          child: Column(
        children: [
          // const Padding(
          //   padding: EdgeInsets.fromLTRB(20, 20, 20, 16),
          //   child: SearchEventsWidget(),
          // ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _profile.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                  child: _buildEventCard(_profile[index]),
                );
              },
            ),
          ),
        ],
      ))
    ]);
  }

  Widget _buildEventCard(Profie event) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: UIColor.solidWhite,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
    );
  }
}

class Profie {
  String name;
  String role;

  Profie({
    required this.name,
    required this.role,
  });
}

List<Profie> getAccount() {
  List<Profie> profie = [];

  profie.add(Profie(
    name: 'Techcom Fest 2027',
    role: 'Competition',
  ));
  return profie;
}
