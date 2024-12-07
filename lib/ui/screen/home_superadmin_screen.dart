import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import '../../data/model/model.dart';
import '../../data/provider/provider.dart';
import '../navigation/navbar_superadmin.dart';
import '../page/accounts_page.dart';
import '../page/approval_page.dart';
import '../page/events_page.dart';
import '../page/explore_page.dart';
import '../page/profile_page.dart';
import '../router/router.dart';

class HomeSuperadminScreen extends StatefulWidget {
  const HomeSuperadminScreen({super.key});

  @override
  State<HomeSuperadminScreen> createState() => _HomeSuperadminScreenState();
}

class _HomeSuperadminScreenState extends State<HomeSuperadminScreen> {
  String token = "";
  String superadminUID = "";
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;

    if (authState is AuthAuthenticated) {
      token = authState.authData.token!;
      superadminUID = authState.authData.data!.userId.toString();
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
      _HomeTabPage(
        token: token,
        superadminUID: superadminUID,
        pageIndex: 0,
      ),
      _HomeTabPage(
        token: token,
        superadminUID: superadminUID,
        pageIndex: 1,
      ),
      _HomeTabPage(
        token: token,
        superadminUID: superadminUID,
        pageIndex: 2,
      ),
      _HomeTabPage(
        token: token,
        superadminUID: superadminUID,
        pageIndex: 3,
      ),
      _HomeTabPage(
        token: token,
        superadminUID: superadminUID,
        pageIndex: 4,
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
              FetchUserById(token: token, userId: superadminUID),
            ),
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
                _currentIndex = index;
              });
            },
            children: _buildWidgetOptions(),
          ),
        ),
        bottomNavigationBar: BottomNavbarSuperadmin(
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

class _HomeTabPage extends StatefulWidget {
  final String token;
  final String superadminUID;
  final int pageIndex;

  const _HomeTabPage({
    required this.token,
    required this.superadminUID,
    required this.pageIndex,
  });

  @override
  State<_HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<_HomeTabPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    switch (widget.pageIndex) {
      case 0:
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => EventBloc()
                ..add(EventFetchData(
                  requestEventCarousel: RequestFilteredEventModel(
                    token: widget.token,
                    status: 'Proposed',
                  ),
                  requestEvent: RequestFilteredEventModel(
                    token: widget.token,
                    postLimit: 6,
                  ),
                  pathRequest: PathRequestEvents.events,
                )),
            ),
            BlocProvider.value(
              value: context.read<UserBloc>(),
            ),
            BlocProvider(
              create: (context) => CategoryBloc()..add(StatusReadData()),
            ),
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
                  adminUserId: widget.superadminUID,
                ),
                pathRequest: PathRequestEvents.events,
              ),
            ),
          child: const HomeApprovalPage(),
        );
      case 3:
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  UserBloc()..add(FetchUser(token: widget.token)),
            ),
            BlocProvider.value(value: context.read<AuthBloc>()),
          ],
          child: const HomeAccountsPage(),
        );
      case 4:
        return BlocProvider.value(
          value: context.read<UserBloc>(),
          child: HomeProfilePage(),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
