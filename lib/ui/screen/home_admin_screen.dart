import 'package:event_proposal_app/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
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
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;

    if (authState is AuthAuthenticated) {
      token = authState.authData.token!;
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
      BlocProvider(
        create: (context) => CategoryBloc()..add(StatusReadData()),
        child: const HomeExplorePage(),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => EventBloc(),
            // ..add(EventFetchData(
            //     requestEvent:
            //         RequestFilteredEventModel(token: token, currentIndex: '0'),
            //     pathRequest: PathRequestEvents.approvedEvents)),
          ),
          BlocProvider.value(
            value: context.read<AuthBloc>(),
          ),
        ],
        child: const HomeEventsPage(),
      ),
      //! Ganti Request Propose By UserId
      BlocProvider(
        create: (context) => EventBloc()
          ..add(EventFetchAllData(
            requestEvent:
                RequestFilteredEventModel(token: token, currentIndex: '0'),
          )),
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
        body: _buildWidgetOptions(token).elementAt(_currentIndex),
        bottomNavigationBar: BottomNavbarAdmin(
          currentIndex: _currentIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
