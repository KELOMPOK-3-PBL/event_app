import 'package:event_proposal_app/ui/page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/bloc.dart';
import '../../data/repository/repository.dart';
import '../screen/detail_event_approval_screen.dart';
import '../screen/detail_event_screen.dart';
import '../screen/home_admin_screen.dart';
import '../screen/home_propose_screen.dart';
import '../screen/home_screen.dart';
import '../screen/home_superadmin_screen.dart';
import '../screen/login_screen.dart';
import '../screen/search_result_event_screen.dart';
import '../screen/splash_screen.dart';
import '../screen/welcome_screen.dart';

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
      GoRoute(
        name: "home",
        path: "/",
        builder: (context, state) {
          return HomeScreen();
        },
        routes: [
          GoRoute(
            name: "detail_event",
            path: "detail_event",
            builder: (context, state) {
              return DetailEventScreen();
            },
          ),
          GoRoute(
            name: "detail_event_approval",
            path: "detail_event_approval",
            builder: (context, state) {
              return DetailEventApprovalScreen();
            },
          ),
          GoRoute(
            name: "detail_profile",
            path: "detail_profile",
            builder: (context, state) {
              return HomeProfilePage();
            },
          ),
          GoRoute(
            name: "search_result_events",
            path: "search_result_events",
            builder: (context, state) {
              return SearchResultEventsScreen(
                searchQuery: state.pathParameters['searchQuery'] ?? 'no query',
              );
            },
          ),
        ],
      ),
    ],
  );

  Widget getHomeScreen(String role) {
    switch (role) {
      case "Superadmin":
        return HomeSuperadminScreen();
      case "Admin":
        return HomeAdminScreen();
      case "Propose":
        return HomeProposeScreen();
      case "Member":
        return HomeScreen();
      default:
        return HomeScreen(); // Fallback
    }
  }
}
