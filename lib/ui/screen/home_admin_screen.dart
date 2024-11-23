import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import '../../data/model/model.dart';
import '../../data/provider/provider.dart';
import '../navigation/bottom_navbar_admin.dart';
import '../page/approval_page.dart';
import '../page/events_page.dart';
import '../page/explore_page.dart';
import '../page/profile_page.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

//! masih salah
class _HomeAdminScreenState extends State<HomeAdminScreen> {
  String token = "";
  String adminUserId = "";
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;

    if (authState is AuthAuthenticated) {
      token = authState.authData.token!;
      adminUserId = authState.authData.data!.userId.toString();
    } else {
      token = '';
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
          BlocProvider(
            create: (context) => EventBloc()
              ..add(EventFetchData(
                  requestEventCarousel: RequestFilteredEventModel(
                      token: token, currentIndex: '0', status: 'Proposed'),
                  requestEvent: RequestFilteredEventModel(
                      token: token, currentIndex: '0'),
                  pathRequest: PathRequestEvents.allEvents)),
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
            EventFetchApprovedData(
              requestEvent:
                  RequestFilteredEventModel(token: token, currentIndex: '0'),
            ),
          ),
        child: const HomeEventsPage(),
      ),
      BlocProvider(
        create: (context) => EventBloc()
          ..add(
            EventFetchDataByProposeOrAdminUserID(
              requestEvent: RequestFilteredEventModel(
                  token: token, currentIndex: '0', adminUserId: adminUserId),
            ),
          ),
        child: const HomeApprovalPage(),
      ),
      const HomeProfilePage(),
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
        bottomNavigationBar: BottomNavbarAdmin(
          currentIndex: _currentIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
