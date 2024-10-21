// import 'package:event_proposal_app/models/search_events.dart';
import 'package:event_proposal_app/models_old/ui_colors.dart';
// import 'package:intl/intl.dart';
// import 'package:uicons_pro/uicons_pro.dart';
import 'package:flutter/material.dart';
import 'package:uicons_pro/uicons_pro.dart';

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
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: SizedBox(
              height: 45,
              child: TextField(
                textInputAction: TextInputAction.search,
                // controller: _searchController,
                maxLines: 1,
                minLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  isDense: true,
                  alignLabelWithHint: true,
                  hintText: 'Search account...',
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                  hintStyle:
                      const TextStyle(color: UIColor.typoGray, fontSize: 14),
                  filled: true,
                  fillColor: UIColor.solidWhite,
                  prefixIcon: Icon(
                    UIconsPro.regularRounded.search,
                    color: UIColor.typoBlack,
                    size: 18,
                  ),
                  suffixIcon: Icon(
                    UIconsPro.regularRounded.settings_sliders,
                    color: UIColor.typoBlack,
                    size: 18,
                  ),
                ),
                onSubmitted: (searchQuery) {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) =>
                  //           SearchAccountResultScreen(searchQuery: searchQuery)),
                  // );
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _account.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                  child: _buildEventCard(_account[index]),
                );
              },
            ),
          ),
        ],
      ))
    ]);
  }

  Widget _buildEventCard(Account account) {
    Color roleColor;
    //! COLORING STATUS BADGE
    if (account.role == "Superadmin") {
      roleColor = UIColor.superadmin;
    } else if (account.role == "Admin") {
      roleColor = UIColor.admin;
    } else if (account.role == "Propose") {
      roleColor = UIColor.propose;
    } else {
      roleColor = UIColor.member;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(
            account.photo,
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              account.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: UIColor.typoBlack,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Container(
              decoration: BoxDecoration(
                color: roleColor,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              child: Text(
                account.role,
                style: const TextStyle(
                  color: UIColor.solidWhite,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Account {
  String name;
  String photo;
  String role;

  Account({
    required this.name,
    required this.photo,
    required this.role,
  });
}

List<Account> getAccount() {
  List<Account> account = [];

  account.add(Account(
    photo:
        'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
    name: 'Mara',
    role: 'Admin',
  ));
  account.add(Account(
    photo:
        'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
    name: 'Sarah',
    role: 'Admin',
  ));
  account.add(Account(
    photo:
        'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
    name: 'Fafa',
    role: 'Member',
  ));
  account.add(Account(
    photo:
        'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
    name: 'Polytechnic Computer Club',
    role: 'Propose',
  ));
  account.add(Account(
    photo:
        'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
    name: 'Rafa Rara',
    role: 'Member',
  ));
  account.add(Account(
    photo:
        'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
    name: 'Rafa Rara',
    role: 'Member',
  ));
  account.add(Account(
    photo:
        'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
    name: 'Rafa Rara',
    role: 'Member',
  ));
  account.add(Account(
    photo:
        'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
    name: 'Rafa Rara',
    role: 'Member',
  ));
  account.add(Account(
    photo:
        'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
    name: 'Rafa Rara',
    role: 'Member',
  ));
  account.add(Account(
    photo:
        'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
    name: 'Rafa Rara',
    role: 'Member',
  ));
  account.add(Account(
    photo:
        'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
    name: 'Rafa Rara',
    role: 'Member',
  ));
  account.add(Account(
    photo:
        'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
    name: 'Rafa Rara',
    role: 'Member',
  ));
  return account;
}
