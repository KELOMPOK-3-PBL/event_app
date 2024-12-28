import 'package:event_proposal_app/data/model/model.dart';
import 'package:event_proposal_app/ui/theme/ui_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uicons_pro/uicons_pro.dart';

import '../../bloc/user_bloc/user_bloc.dart';
import '../router/router.dart';

class HomeAccountsPage extends StatefulWidget {
  const HomeAccountsPage({super.key});

  @override
  State<HomeAccountsPage> createState() => _HomeAccountsPageState();
}

class _HomeAccountsPageState extends State<HomeAccountsPage> {
  final _scrollController = ScrollController();
  String? searchUser;
  // String? userId;
  String? sort;
  String? order;
  String? role;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onScroll() {
    if (_isBottom) {
      //! mengatasi perubahan request ketika di scroll
      context.read<UserBloc>().add(
            FetchUser(
              searchUser: searchUser,
              sort: sort,
              order: order,
              role: role,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<UserBloc>().add(
              FetchUser(
                isReload: true,
                searchUser: searchUser,
                sort: sort,
                order: order,
                role: role,
              ),
            );
      },
      child: Column(
        children: [
          AppBar(
            shadowColor: UIColor.shadowColor,
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
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10.0),
                        hintStyle: const TextStyle(
                            color: UIColor.typoGray, fontSize: 14),
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
                  child: BlocConsumer<UserBloc, UserState>(
                    listener: (context, state) {
                      if (state is UsersLoaded) {
                        searchUser = state.searchUser;
                      }
                    },
                    builder: (context, state) {
                      if (state is UserLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is UsersLoaded) {
                        // debugPrint(state.listUser.toString());
                        return ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.zero,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: (state.hasReachedMax)
                              ? state.listUser.length
                              : state.listUser.length + 1,
                          itemBuilder: (context, index) {
                            if (index >= state.listUser.length) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRouter.detailAccount,
                                    arguments: {
                                      // 'token': token,
                                      'user_id': state.listUser[index].userid
                                          .toString(),
                                    },
                                  );
                                },
                                child: _buildEventCard(state.listUser[index]),
                              );
                            }
                          },
                        );
                      } else {
                        return Center(
                          child: Text('No Accounts'),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEventCard(UserDataModel account) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      color: Colors.transparent,
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.all(
      //       Radius.circular(10),
      //     )),
      width: MediaQuery.of(context).size.width,
      // padding: const EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: UIColor.solidWhite,
            radius: 24,
            backgroundImage: NetworkImage(
              account.avatar
                  // : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                  ??
                  'https://img.freepik.com/free-vector/illustration-businessman_53876-5856.jpg?t=st=1729955954~exp=1729959554~hmac=21f4e9f848ed4521b47e6041fcd202d019651577ec676e23bba8e7fe93adce16&w=826',
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
                    itemCount: account.roles!.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: UIColor.getRoleColor(account.roles![index]),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            account.roles![index],
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
        ],
      ),
    );
  }
}
