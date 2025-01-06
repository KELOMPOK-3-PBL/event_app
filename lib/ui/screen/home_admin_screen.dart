import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import '../../data/model/model.dart';
import '../../data/provider/provider.dart';
import '../navigation/navbar_admin.dart';
import '../page/approval_page.dart';
import '../page/events_page.dart';
import '../page/explore_page.dart';
import '../page/profile_page.dart';
import '../router/router.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  String token = "";
  String adminUID = "";
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;

    if (authState is AuthAuthenticated) {
      token = authState.authData.accessToken!;
      adminUID = authState.authData.data!.userId.toString();
      // context
      //     .read<UserBloc>()
      //     .add(FetchUserById(token: token, userId: adminUID));
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
        adminUID: adminUID,
        pageIndex: 0,
      ),
      _HomeTabPage(
        token: token,
        adminUID: adminUID,
        pageIndex: 1,
      ),
      _HomeTabPage(
        token: token,
        adminUID: adminUID,
        pageIndex: 2,
      ),
      _HomeTabPage(
        token: token,
        adminUID: adminUID,
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
          create: (context) => UserBloc(authBloc: context.read<AuthBloc>())
            ..add(
              FetchUserById(userId: adminUID),
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
                _currentIndex = index; // Sinkronkan indeks aktif
              });
            },
            children: _buildWidgetOptions(),
          ),
        ),
        bottomNavigationBar: BottomNavbarAdmin(
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
  final String adminUID;
  final int pageIndex;

  const _HomeTabPage({
    required this.token,
    required this.adminUID,
    required this.pageIndex,
  });

  @override
  State<_HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<_HomeTabPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // Pertahankan state halaman

  @override
  Widget build(BuildContext context) {
    super.build(context); // Memanggil build dari AutomaticKeepAliveClientMixin

    // Sesuaikan halaman berdasarkan pageIndex
    switch (widget.pageIndex) {
      case 0:
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: context.read<UserBloc>(),
            ),
            BlocProvider(
              create: (context) => EventBloc(authBloc: context.read<AuthBloc>())
                ..add(EventFetchData(
                    requestEventCarousel: RequestFilteredEventModel(
                        token: widget.token, status: 'Proposed'),
                    requestEvent: RequestFilteredEventModel(
                        token: widget.token, postLimit: 6),
                    pathRequest: PathRequestEvents.events)),
            ),
            BlocProvider(
              create: (context) => CategoryBloc()..add(StatusReadData()),
            ),
          ],
          child: HomeExplorePage(token: widget.token),
        );
      case 1:
        return BlocProvider(
          create: (context) => EventBloc(authBloc: context.read<AuthBloc>())
            ..add(
              EventFetchData(
                requestEvent: RequestFilteredEventModel(token: widget.token),
                pathRequest: PathRequestEvents.approvedEvents,
              ),
            ),
          child: const HomeEventsPage(),
        );
      case 2:
        return BlocProvider(
          create: (context) => EventBloc(authBloc: context.read<AuthBloc>())
            ..add(
              EventFetchData(
                requestEvent: RequestFilteredEventModel(
                    token: widget.token,
                    adminUserId: widget.adminUID,
                    postLimit: 5,
                    currentIndex: 0),
                pathRequest: PathRequestEvents.events,
              ),
            ),
          child: const HomeApprovalPage(),
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
