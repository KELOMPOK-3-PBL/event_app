// import 'package:event_proposal_app/models/search_events.dart';
import 'package:event_proposal_app/data/model/model.dart';
// import 'package:event_proposal_app/ui/router/router.dart';
import 'package:event_proposal_app/ui/theme/ui_colors.dart';
// import 'package:intl/intl.dart';
// import 'package:uicons_pro/uicons_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uicons_pro/uicons_pro.dart';

import '../../bloc/user_bloc/user_bloc.dart';

class HomeAccountsPage extends StatefulWidget {
  const HomeAccountsPage({super.key});

  @override
  State<HomeAccountsPage> createState() => _HomeAccountsPageState();
}

class _HomeAccountsPageState extends State<HomeAccountsPage> {
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
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UsersLoaded) {
                  debugPrint(state.listUser.toString());
                  return GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, AppRouter.detailProfile);
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: state.listUser.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                          child: _buildEventCard(state.listUser[index]),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Text('No Users Found'),
                  );
                }
              },
            ),
          ),
        ],
      ))
    ]);
  }

  Widget _buildEventCard(UserModel account) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: UIColor.solidWhite,
          radius: 24,
          backgroundImage: NetworkImage(
            account.avatar != null
                ? account.avatar!
                : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
          ),
          onBackgroundImageError: (exception, stackTrace) {
            // Tangani error di sini
            debugPrint('Failed to load image: $exception');
          },
          // child: Image.network(
          //   account.avatar != null ? account.avatar! : 'error',
          //   errorBuilder: (context, error, stackTrace) => Image.asset(
          //     'assets/images/image_not_found.png',
          //     fit: BoxFit.fill,
          //   ),
          //   // Icon(Icons.person),
          // ),
        ),
        SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Username
              Text(
                account.username,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: UIColor.typoBlack,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6), // Spacing between username and roles
              // Roles badges
              SizedBox(
                height: 18,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: account.roles.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: UIColor.getRoleColor(account.roles[index]),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          account.roles[index],
                          style: const TextStyle(
                            color: UIColor.solidWhite,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Text(
        //       account.username,
        //       style: const TextStyle(
        //         fontSize: 14,
        //         fontWeight: FontWeight.bold,
        //         color: UIColor.typoBlack,
        //       ),
        //       maxLines: 2,
        //       overflow: TextOverflow.ellipsis,
        //     ),
        //     SizedBox(
        //       child: ListView.separated(
        //         shrinkWrap: true,
        //         padding: EdgeInsets.zero,
        //         scrollDirection: Axis.horizontal,
        //         physics: const NeverScrollableScrollPhysics(),
        //         itemCount: account.roles.length,
        //         separatorBuilder: (context, index) => const SizedBox(
        //           width: 10,
        //         ),
        //         itemBuilder: (context, index) {
        //           debugPrint(account.roles.toString());
        //           return Container(
        //             decoration: BoxDecoration(
        //               color: UIColor.getRoleColor(account.roles[index]),
        //               borderRadius: BorderRadius.circular(4),
        //             ),
        //             padding:
        //                 const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        //             child: Text(
        //               account.roles[index],
        //               style: const TextStyle(
        //                 color: UIColor.solidWhite,
        //                 fontSize: 10,
        //                 fontWeight: FontWeight.w400,
        //               ),
        //             ),
        //           );
        //         },
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

// class Account {
//   String name;
//   String photo;
//   String role;

//   Account({
//     required this.name,
//     required this.photo,
//     required this.role,
//   });
// }

// List<Account> getAccount() {
//   List<Account> account = [];

//   account.add(Account(
//     photo:
//         'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
//     name: 'Mara',
//     role: 'Admin',
//   ));
//   account.add(Account(
//     photo:
//         'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
//     name: 'Sarah',
//     role: 'Admin',
//   ));
//   account.add(Account(
//     photo:
//         'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
//     name: 'Fafa',
//     role: 'Member',
//   ));
//   account.add(Account(
//     photo:
//         'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
//     name: 'Polytechnic Computer Club',
//     role: 'Propose',
//   ));
//   account.add(Account(
//     photo:
//         'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
//     name: 'Rafa Rara',
//     role: 'Member',
//   ));
//   account.add(Account(
//     photo:
//         'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
//     name: 'Rafa Rara',
//     role: 'Member',
//   ));
//   account.add(Account(
//     photo:
//         'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
//     name: 'Rafa Rara',
//     role: 'Member',
//   ));
//   account.add(Account(
//     photo:
//         'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
//     name: 'Rafa Rara',
//     role: 'Member',
//   ));
//   account.add(Account(
//     photo:
//         'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
//     name: 'Rafa Rara',
//     role: 'Member',
//   ));
//   account.add(Account(
//     photo:
//         'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
//     name: 'Rafa Rara',
//     role: 'Member',
//   ));
//   account.add(Account(
//     photo:
//         'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
//     name: 'Rafa Rara',
//     role: 'Member',
//   ));
//   account.add(Account(
//     photo:
//         'https://cdn.pixabay.com/photo/2021/06/25/13/22/girl-6363743_1280.jpg',
//     name: 'Rafa Rara',
//     role: 'Member',
//   ));
//   return account;
// }
