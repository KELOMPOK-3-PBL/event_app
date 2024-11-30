import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import '../../data/model/model.dart';
import '../../data/provider/provider.dart';
import '../navigation/bottom_navbar_superadmin.dart';
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
    });
  }

  List<Widget> _buildWidgetOptions(String token) {
    return [
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<AuthBloc>()),
          BlocProvider(
            create: (context) => EventBloc()
              ..add(EventFetchData(
                  requestEventCarousel: RequestFilteredEventModel(
                      token: token, currentIndex: '0', status: 'Proposed'),
                  requestEvent: RequestFilteredEventModel(
                      token: token, currentIndex: '0'),
                  pathRequest: PathRequestEvents.events)),
          ),
          BlocProvider(
            create: (context) => CategoryBloc()..add(StatusReadData()),
          ),
        ],
        child: HomeExplorePage(token: token),
      ),
      BlocProvider(
        create: (context) => EventBloc()
          ..add(
            EventFetchData(
              requestEvent: RequestFilteredEventModel(
                token: token, currentIndex: '0',
                // adminUserId: adminUserId
              ),
              pathRequest: PathRequestEvents.approvedEvents,
            ),
          ),
        child: HomeEventsPage(),
      ),
      BlocProvider(
        create: (context) => EventBloc()
          ..add(
            EventFetchData(
              requestEvent: RequestFilteredEventModel(
                  token: token, currentIndex: '0', adminUserId: superadminUID),
              pathRequest: PathRequestEvents.events,
            ),
          ),
        child: HomeApprovalPage(),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserBloc()..add(FetchUser(token: token)),
          ),
          BlocProvider.value(
            value: context.read<AuthBloc>(),
          ),
        ],
        child: HomeAccountsPage(),
      ),
      BlocProvider(
        create: (context) =>
            UserBloc()..add(FetchUserById(token: token, userId: superadminUID)),
        child: const HomeProfilePage(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (token.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text("User is not authenticated. Please log in."),
        ),
      );
    }

    return BlocProvider.value(
      value: context.read<AuthBloc>(),
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _buildWidgetOptions(token),
        ),
        // _buildWidgetOptions(token).elementAt(_currentIndex),
        bottomNavigationBar: BottomNavbarSuperadmin(
          currentIndex: _currentIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
