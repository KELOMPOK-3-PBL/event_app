import 'package:event_proposal_app/ui/page/accounts_page.dart';
import 'package:event_proposal_app/ui/page/approval_page.dart';
import 'package:event_proposal_app/ui/page/events_page.dart';
import 'package:event_proposal_app/ui/page/explore_page.dart';
import 'package:event_proposal_app/ui/page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/bloc.dart';
import '../screen/detail_event_approval_screen.dart';
import '../screen/detail_event_screen.dart';
import '../screen/home_screen.dart';
import '../screen/login_screen.dart';
import '../screen/search_result_event_screen.dart';
import '../screen/splash_screen.dart';
import '../screen/welcome_screen.dart';

// final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

class AppGoRoutes {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: "splash",
        path: "/splash",
        builder: (context, state) {
          return SplashScreen();
        },
        routes: [
          GoRoute(
            name: "welcome",
            path: "/welcome",
            builder: (context, state) {
              return WelcomeScreen();
            },
            routes: [
              GoRoute(
                name: "login",
                path: "/login",
                builder: (context, state) {
                  return LoginScreen();
                },
              ),
            ],
          ),
        ],
      ),
      ShellRoute(
        // name: "home",
        // path: "/",
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          // final int indexNav;
          return HomeScreen(child: child);
          // return BottomNavigationBarScaffold(child: child);
          // Scaffold(
          //   // body: ,
          //   bottomNavigationBar: BottomNavbar(
          //     currentIndex: indexNav,
          //     onItemTapped: (indexNav) {
          //       final routes = [
          //         'explore',
          //         'events',
          //         'approval',
          //         'accounts',
          //         'profile'
          //       ];
          //       context.goNamed(routes[indexNav]);
          //     },
          //   ),
          // );
        },
        routes: [
          GoRoute(
            name: "explore",
            path: "/",
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) {
              return MultiBlocProvider(providers: [
                // BlocProvider(create: (context) => AuthBloc()),
                // BlocProvider.value(value: context.read<AuthBloc>()),
                BlocProvider(
                    create: (context) => CategoryBloc()..add(StatusReadData())),
                // BlocProvider(
                //     create: (context) => EventBloc()
                //       // create: (context) => EventBloc(
                //       //     authState: context.read<AuthBloc>().state)

                //       // create: (context) => EventBloc(
                //       //     eventRepository: EventRepository(), authBloc: AuthBloc())
                //       ..add(EventFetched()))
              ], child: HomeExplorePage());
            },
            // routes: [
            //   GoRoute(
            //     name: "detail_event",
            //     path: "detail_event",
            //     builder: (context, state) {
            //       return DetailEventScreen();
            //     },
            //   ),
            //   GoRoute(
            //     name: "search_result_events",
            //     path: "search_result_events",
            //     builder: (context, state) {
            //       return SearchResultEventsScreen(
            //         searchQuery:
            //             state.pathParameters['searchQuery'] ?? 'no query',
            //       );
            //     },
            //   ),
            // ],
          ),
          GoRoute(
            name: "events",
            path: "/events",
            // parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) {
              return HomeEventsPage();
            },
            routes: [
              GoRoute(
                name: "detail_event",
                path: "detail_event",
                // parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  return DetailEventScreen();
                },
              ),
              GoRoute(
                name: "search_result_events",
                path: "search_result_events",
                // parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  debugPrint(state.pathParameters['searchQuery']);
                  return SearchResultEventsScreen(
                    searchQuery:
                        state.pathParameters['searchQuery'] ?? 'no query',
                  );
                },
              ),
            ],
          ),
          GoRoute(
            name: "approval",
            path: "/approval",
            // parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) {
              return HomeApprovalPage();
            },
            routes: [
              GoRoute(
                name: "detail_event_approval",
                path: "detail_event_approval",
                // parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  return DetailEventApprovalScreen();
                },
              ),
            ],
          ),
          GoRoute(
            name: "accounts",
            path: "/accounts",
            // parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) {
              return HomeAccountsPage();
            },
            routes: [
              GoRoute(
                name: "detail_profile",
                path: "detail_profile",
                // parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  return HomeProfilePage();
                },
              ),
            ],
          ),
          GoRoute(
            name: "profile",
            path: "/profile",
            // parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) {
              return HomeProfilePage();
            },
          ),
        ],
      ),
    ],
  );

  // Widget getHomeScreen(String role) {
  //   switch (role) {
  //     case "Superadmin":
  //       return HomeSuperadminScreen();
  //     case "Admin":
  //       return HomeAdminScreen();
  //     case "Propose":
  //       return HomeProposeScreen();
  //     case "Member":
  //       return HomeScreen();
  //     default:
  //       return HomeScreen(); // Fallback
  //   }
  // }
}
