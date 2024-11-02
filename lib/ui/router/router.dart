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

// enum UserRole {
//   admin,
//   superadmin,
//   propose,
//   member,
// }

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/splash': (context) => SplashScreen(),
    '/welcome': (context) => WelcomeScreen(),
    '/login': (context) => BlocProvider(
          create: (context) => AuthBloc(),
          child: LoginScreen(),
        ),
    '/': (context) {
      final authState = context.read<AuthBloc>().state;

      if (!authState.isAuthenticated) {
        return LoginScreen(); // Redirect to login if not authenticated
      }

      return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
          BlocProvider<EventBloc>(
            create: (context) => EventBloc(
              eventRepository: EventRepository(),
              authBloc: context
                  .read<AuthBloc>(), // Use the existing AuthBloc instance
            )..add(EventFetched()),
          ),
          BlocProvider<CategoryBloc>(
            create: (context) => CategoryBloc(
              categoryRepository: StatusRepository(),
            )..add(CategoryReadData()),
          ),
        ],
        child: getHomeScreen(authState.userRole), // Redirect based on role
      );
    },
    '/homeAdmin': (context) => MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
            BlocProvider<EventBloc>(
                //! memanggil AuthBloc di dalam bloc EventBloc
                create: (context) => EventBloc(
                    eventRepository: EventRepository(), authBloc: AuthBloc())
                  ..add(EventFetched())),
            BlocProvider<CategoryBloc>(
                create: (context) =>
                    CategoryBloc(categoryRepository: StatusRepository())
                      ..add(CategoryReadData())),
          ],
          child: HomeAdminScreen(),
        ),
    '/homeSuperadmin': (context) => MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
            BlocProvider<EventBloc>(
                //! memanggil AuthBloc di dalam bloc EventBloc
                create: (context) => EventBloc(
                    eventRepository: EventRepository(), authBloc: AuthBloc())
                  ..add(EventFetched())),
            BlocProvider<CategoryBloc>(
                create: (context) =>
                    CategoryBloc(categoryRepository: StatusRepository())
                      ..add(CategoryReadData())),
          ],
          child: HomeSuperadminScreen(),
        ),
    '/homePropose': (context) => MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
            BlocProvider<EventBloc>(
                //! memanggil AuthBloc di dalam bloc EventBloc
                create: (context) => EventBloc(
                    eventRepository: EventRepository(), authBloc: AuthBloc())
                  ..add(EventFetched())),
            BlocProvider<CategoryBloc>(
                create: (context) =>
                    CategoryBloc(categoryRepository: StatusRepository())
                      ..add(CategoryReadData())),
          ],
          child: HomeProposeScreen(),
        ),
    '/detailEvent': (context) => MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
            BlocProvider<EventBloc>(
                //! memanggil AuthBloc di dalam bloc EventBloc
                create: (context) => EventBloc(
                    eventRepository: EventRepository(), authBloc: AuthBloc())
                  ..add(EventFetched())),
            BlocProvider<CategoryBloc>(
                create: (context) =>
                    CategoryBloc(categoryRepository: StatusRepository())
                      ..add(CategoryReadData())),
          ],
          child: DetailEventScreen(),
        ),
    '/detailEventApproval': (context) => MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
            BlocProvider<EventBloc>(
                //! memanggil AuthBloc di dalam bloc EventBloc
                create: (context) => EventBloc(
                    eventRepository: EventRepository(), authBloc: AuthBloc())
                  ..add(EventFetched())),
            BlocProvider<CategoryBloc>(
                create: (context) =>
                    CategoryBloc(categoryRepository: StatusRepository())
                      ..add(CategoryReadData())),
          ],
          child: DetailEventApprovalScreen(),
        ),
    '/searchResultEvent': (context) => MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
            BlocProvider<EventBloc>(
                //! memanggil AuthBloc di dalam bloc EventBloc
                create: (context) => EventBloc(
                    eventRepository: EventRepository(), authBloc: AuthBloc())
                  ..add(EventFetched())),
            BlocProvider<CategoryBloc>(
                create: (context) =>
                    CategoryBloc(categoryRepository: StatusRepository())
                      ..add(CategoryReadData())),
          ],
          child: SearchResultEventsScreen(
            searchQuery: '',
          ),
        ),
  };
}

Widget getHomeScreen(UserRole role) {
  switch (role) {
    case UserRole.admin:
      return HomeAdminScreen();
    case UserRole.superadmin:
      return HomeSuperadminScreen();
    case UserRole.propose:
      return HomeProposeScreen();
    case UserRole.member:
      return HomeScreen();
    default:
      return HomeScreen(); // Fallback
  }
}
