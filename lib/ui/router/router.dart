import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/category_bloc/category_bloc.dart';
import '../../bloc/event_bloc/event_bloc.dart';
import '../screen/detail_event_approval_screen.dart';
import '../screen/detail_event_screen.dart';
import '../screen/home_admin_screen.dart';
import '../screen/home_propose_screen.dart';
import '../screen/home_superadmin_screen.dart';
import '../screen/login_screen.dart';
import '../screen/search_result_event_screen.dart';
import '../screen/settings_screen.dart';
import '../screen/splash_screen.dart';
import '../screen/welcome_screen.dart';

class AppRouter {
  static const String splashRoute = '/splash';
  static const String welcomeRoute = '/welcome';
  static const String loginRoute = '/login';
  static const String homeRoute = '/';
  static const String detailEventRoute = '/detailEvent';
  static const String settingsRoute = '/settings';
  static const String detailEventApprovalRoute = '/detailEventApproval';
  static const String searchResultEventRoute = '/searchResultEvent';

  static Map<String, WidgetBuilder> routes = {
    splashRoute: (context) => const SplashScreen(),
    welcomeRoute: (context) => const WelcomeScreen(),
    loginRoute: (context) => BlocProvider(
          create: (context) => AuthBloc()..add(AuthLoadRememberMe()),
          child: const LoginScreen(),
        ),
    homeRoute: (context) {
      final String role = ModalRoute.of(context)!.settings.arguments.toString();
      return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<AuthBloc>()),
          BlocProvider(
              create: (context) => CategoryBloc()..add(StatusReadData())),
          BlocProvider(create: (context) => EventBloc()..add(EventFetchData())),
        ],
        child: getHomeScreen(role),
      );
    },
    detailEventRoute: (context) => const DetailEventScreen(),
    settingsRoute: (context) => BlocProvider.value(
          value: context.read<AuthBloc>(),
          child: const SettingsScreen(),
        ),
    detailEventApprovalRoute: (context) => const DetailEventApprovalScreen(),
    searchResultEventRoute: (context) => const SearchResultEventsScreen(
          searchQuery: '',
        ),
  };

  static Widget getHomeScreen(String role) {
    switch (role) {
      case 'Superadmin':
        return const HomeSuperadminScreen();
      case 'Admin':
        return const HomeAdminScreen();
      case 'Propose':
        return const HomeProposeScreen();
      case 'Member':
        return const HomeProposeScreen();
      default:
        return const LoginScreen(); // Fallback
    }
  }
}
