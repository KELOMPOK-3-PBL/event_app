import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uicons_pro/uicons_pro.dart';

import '../../bloc/bloc.dart';
import '../../data/model/model.dart';
import '../../data/provider/provider.dart';
import '../page/events_page.dart';
import '../page/explore_page.dart';
import '../page/profile_page.dart';
import '../router/router.dart';
import '../navigation/navbar_propose.dart';
import '../page/propose_page.dart';
import '../theme/ui_colors.dart';

class HomeProposeScreen extends StatefulWidget {
  const HomeProposeScreen({super.key});

  @override
  State<HomeProposeScreen> createState() => _HomeProposeScreenState();
}

class _HomeProposeScreenState extends State<HomeProposeScreen> {
  String token = "";
  String proposeUID = "";
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;

    if (authState is AuthAuthenticated) {
      token = authState.authData.token!;
      proposeUID = authState.authData.data!.userId.toString();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRouter.loginRoute,
          (Route<dynamic> route) => false,
        );
      });
      debugPrint("User is not authenticated.");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  List<Widget> _buildWidgetOptions() {
    return [
      _HomeProposeTabPage(
        token: token,
        proposeUID: proposeUID,
        pageIndex: 0,
      ),
      _HomeProposeTabPage(
        token: token,
        proposeUID: proposeUID,
        pageIndex: 1,
      ),
      _HomeProposeTabPage(
        token: token,
        proposeUID: proposeUID,
        pageIndex: 2,
      ),
      _HomeProposeTabPage(
        token: token,
        proposeUID: proposeUID,
        pageIndex: 3,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (token.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text("User is not authenticated. Please log in."),
        ),
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: context.read<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => UserBloc()
            ..add(
              FetchUserById(token: token, userId: proposeUID),
            ),
        ),
        BlocProvider(
          create: (context) => CategoryBloc()..add(CategoryReadData()),
        ),
      ],
      child: Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index; // Sinkronkan indeks aktif
              });
            },
            children: _buildWidgetOptions(),
          ),
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(right: 13),
          decoration: BoxDecoration(
            color: UIColor.propose,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              CategoryModel? categories;
              if (state is CategoryLoaded) {
                categories = state.categoryData;
                // debugPrint(state.categoryData.categories.toString());
              }
              return IconButton(
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      Navigator.pushNamed(
                          context, AppRouter.formProposeEventRoute,
                          arguments: categories);
                    },
                  );
                },
                icon: Icon(
                  UIconsPro.solidRounded.file_upload,
                  color: UIColor.solidWhite,
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: BottomNavbarPropose(
          currentIndex: _currentIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class _HomeProposeTabPage extends StatefulWidget {
  final String token;
  final String proposeUID;
  final int pageIndex;

  const _HomeProposeTabPage({
    required this.token,
    required this.proposeUID,
    required this.pageIndex,
  });

  @override
  State<_HomeProposeTabPage> createState() => _HomeProposeTabPageState();
}

class _HomeProposeTabPageState extends State<_HomeProposeTabPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // Pertahankan state halaman

  @override
  Widget build(BuildContext context) {
    super.build(context); // Memanggil build dari AutomaticKeepAliveClientMixin

    switch (widget.pageIndex) {
      case 0:
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => EventBloc()
                ..add(
                  EventFetchData(
                    requestEventCarousel: RequestFilteredEventModel(
                      token: widget.token,
                    ),
                    requestEvent: RequestFilteredEventModel(
                        token: widget.token, postLimit: 6),
                    pathRequest: PathRequestEvents.approvedEvents,
                  ),
                ),
            ),
            BlocProvider.value(
              value: context.read<UserBloc>(),
            ),
            BlocProvider.value(
              value: context.read<CategoryBloc>(),
            )
            // BlocProvider(
            //   create: (context) => CategoryBloc()..add(CategoryReadData()),
            // ),
          ],
          child: HomeExplorePage(token: widget.token),
        );
      case 1:
        return BlocProvider(
          create: (context) => EventBloc()
            ..add(
              EventFetchData(
                requestEvent: RequestFilteredEventModel(
                  token: widget.token,
                ),
                pathRequest: PathRequestEvents.approvedEvents,
              ),
            ),
          child: const HomeEventsPage(),
        );
      case 2:
        return BlocProvider(
          create: (context) => EventBloc()
            ..add(
              EventFetchData(
                requestEvent: RequestFilteredEventModel(
                  token: widget.token,
                ),
                pathRequest: PathRequestEvents.events,
              ),
            ),
          child: const HomeProposePage(),
        );
      case 3:
        return BlocProvider.value(
          value: context.read<UserBloc>(),
          child: HomeProfilePage(),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
