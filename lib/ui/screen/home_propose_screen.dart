import 'package:event_proposal_app/data/provider/provider.dart';
import 'package:event_proposal_app/ui/router/router.dart';
import 'package:event_proposal_app/ui/theme/ui_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uicons_pro/uicons_pro.dart';

import '../../bloc/bloc.dart';
import '../../data/model/model.dart';
import '../navigation/bottom_navbar_propose.dart';
import '../page/events_page.dart';
import '../page/explore_page.dart';
import '../page/profile_page.dart';
import '../page/propose_page.dart';

class HomeProposeScreen extends StatefulWidget {
  const HomeProposeScreen({super.key});

  @override
  State<HomeProposeScreen> createState() => _HomeProposeScreenState();
}

//! masih salah
class _HomeProposeScreenState extends State<HomeProposeScreen> {
  String token = "";
  String proposeUID = "";
  int _currentIndex = 0;

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
    });
  }

  List<Widget> _buildWidgetOptions(String token) {
    return [
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => EventBloc()
              ..add(
                EventFetchData(
                    requestEventCarousel: RequestFilteredEventModel(
                      token: token,
                      currentIndex: '0',
                    ),
                    requestEvent: RequestFilteredEventModel(
                        token: token, currentIndex: '0'),
                    pathRequest: PathRequestEvents.approvedEvents),
              ),
          ),
          BlocProvider(
            create: (context) => UserBloc()
              ..add(FetchUserById(token: token, userId: proposeUID)),
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
              requestEvent:
                  RequestFilteredEventModel(token: token, currentIndex: '0'),
              pathRequest: PathRequestEvents.approvedEvents,
            ),
          ),
        child: const HomeEventsPage(),
      ),
      BlocProvider(
        create: (context) => EventBloc()
          ..add(
            EventFetchData(
              requestEvent:
                  RequestFilteredEventModel(token: token, currentIndex: '0'),
              pathRequest: PathRequestEvents.events,
            ),
          ),
        child: const HomeProposePage(),
      ),
      BlocProvider(
        create: (context) =>
            UserBloc()..add(FetchUserById(token: token, userId: proposeUID)),
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
        floatingActionButton: Container(
          margin: EdgeInsets.only(right: 13),
          decoration: BoxDecoration(
              color: UIColor.propose,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRouter.formProposeEventRoute),
            icon: Icon(
              UIconsPro.solidRounded.file_upload,
              color: UIColor.solidWhite,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavbarPropose(
          currentIndex: _currentIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
