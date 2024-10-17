// import 'package:event_proposal_app/models/search_events.dart';
import 'package:event_proposal_app/models/ui_colors.dart';
import 'package:intl/intl.dart';
import 'package:uicons_pro/uicons_pro.dart';
import 'package:flutter/material.dart';

class HomeAccounts extends StatefulWidget {
  const HomeAccounts({super.key});

  @override
  State<HomeAccounts> createState() => _HomeAccountsState();
}

class _HomeAccountsState extends State<HomeAccounts> {
  late List<Account> _account;

  @override
  void initState() {
    super.initState();
    _account = getAccount();
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
          "Account",
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
              itemCount: _account.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                  child: _buildEventCard(_account[index]),
                );
              },
            ),
          ),
        ],
      ))
    ]);
  }

  Widget _buildEventCard(Account event) {
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

class Account {
  String name;
  String role;

  Account({
    required this.name,
    required this.role,
  });
}

List<Account> getAccount() {
  List<Account> account = [];

  account.add(Account(
    name: 'Techcom Fest 2027',
    role: 'Competition',
  ));
  account.add(Account(
    name: 'AI For Technology ',
    role: 'Seminar',
  ));
  account.add(Account(
    name: 'Electro Fest',
    role: 'Expo',
  ));
  account.add(Account(
    name: 'Electro Fest',
    role: 'Expo',
  ));
  account.add(Account(
    name: 'Electro Fest',
    role: 'Expo',
  ));
  account.add(Account(
    name: 'Electro Fest',
    role: 'Expo',
  ));
  account.add(Account(
    name: 'Electro Fest',
    role: 'Expo',
  ));
  account.add(Account(
    name: 'Electro Fest',
    role: 'Expo',
  ));
  account.add(Account(
    name: 'Electro Fest',
    role: 'Expo',
  ));
  account.add(Account(
    name: 'Electro Fest',
    role: 'Expo',
  ));
  account.add(Account(
    name: 'Electro Fest',
    role: 'Expo',
  ));

  account.add(Account(
    name: 'Electro Fest',
    role: 'Expo',
  ));
  account.add(Account(
    name: 'Electro Fest',
    role: 'Expo',
  ));
  return account;
}
