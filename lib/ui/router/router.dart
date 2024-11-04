import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/splash': (context) => SplashScreen(),
    '/welcome': (context) => WelcomeScreen(),
    '/login': (context) => BlocProvider(
          create: (context) => AuthBloc(),
          child: LoginScreen(),
        ),
    '/': (context) {
      final String role = ModalRoute.of(context)!.settings.arguments.toString();
      // print("You are Login as: " + role);
      return MultiBlocProvider(providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(
            create: (context) =>
                CategoryBloc(categoryRepository: StatusRepository())
                  ..add(CategoryReadData())),
        BlocProvider(
            create: (context) => EventBloc()
              // create: (context) => EventBloc(
              //     authState: context.read<AuthBloc>().state)

              // create: (context) => EventBloc(
              //     eventRepository: EventRepository(), authBloc: AuthBloc())
              ..add(EventFetched()))
      ], child: getHomeScreen(role));
      // Redirect based on role
    },
    '/detailEvent': (context) => DetailEventScreen(),
    '/detailEventApproval': (context) => DetailEventApprovalScreen(),
    '/searchResultEvent': (context) => SearchResultEventsScreen(
          searchQuery: '',
        ),
  };
}

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
