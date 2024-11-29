import 'package:event_proposal_app/data/model/model.dart';
import 'package:event_proposal_app/ui/page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import '../screen/detail_event_approval_screen.dart';
import '../screen/detail_event_screen.dart';
import '../screen/form_propose_event.dart';
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
  static const String initialRoute = '/initial';
  static const String detailEventRoute = '/detail_event';
  static const String settingsRoute = '/settings';
  static const String detailEventProposeRoute = '/detail_event_propose';
  static const String detailEventApprovalRoute = '/detail_event_approval';
  static const String searchResultEventRoute = '/search_result_event';
  static const String formProposeEventRoute = '/form_propose_event';
  static const String detailProfile = '/detail_profile';

  static Map<String, WidgetBuilder> routes = {
    initialRoute: (context) {
      return BlocProvider.value(
        value: context.read<AuthBloc>(),
        child: BlocListener<AuthBloc, AuthState>(
          child: WelcomeScreen(),
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              if (state.currentRole != null) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRouter.homeRoute,
                  (Route<dynamic> route) => false,
                  arguments: state.currentRole,
                );
              } else {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRouter.loginRoute,
                  (Route<dynamic> route) => false,
                );
              }
            } else if (state is AuthUnauthenticated) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRouter.loginRoute,
                (Route<dynamic> route) => false,
              );
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRouter.splashRoute,
                (Route<dynamic> route) => false,
              );
            }
            // });
          },
          // builder: (context, state) {
          //   if (state is AuthLoading) {
          //     return const SplashScreen(); // Tampilkan SplashScreen saat loading
          //   }
          //   return const SplashScreen(); // Fallback
          // },
        ),
      );
    },
    splashRoute: (context) => const SplashScreen(),
    welcomeRoute: (context) => const WelcomeScreen(),
    loginRoute: (context) => BlocProvider.value(
          value: context.read<AuthBloc>()..add(AuthLoadRememberMe()),
          child: const LoginScreen(),
        ),
    homeRoute: (context) {
      final String role = ModalRoute.of(context)!.settings.arguments.toString();
      return BlocProvider.value(
        value: context.read<AuthBloc>()
        // ..add(
        //   AuthSaveCurrentRole(currentRole: role),
        // )
        ,
        child: getHomeScreen(role),
      );
    },

    detailEventRoute: (context) => const DetailEventScreen(),
    settingsRoute: (context) => BlocProvider.value(
          value: context.read<AuthBloc>(),
          child: const SettingsScreen(),
        ),
    detailEventApprovalRoute: (context) {
      final EventDataModel arguments =
          ModalRoute.of(context)!.settings.arguments as EventDataModel;
      // BlocProvider.value(
      //       value: context.read<EventBloc>(),
      // child:
      return DetailEventApprovalScreen(data: arguments);
    },
    // ),
    detailEventProposeRoute: (context) {
      final EventDataModel arguments =
          ModalRoute.of(context)!.settings.arguments as EventDataModel;
      // BlocProvider.value(
      //       value: context.read<EventBloc>(),
      // child:
      return DetailEventApprovalScreen(data: arguments);
    },

    searchResultEventRoute: (context) {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      String searchQuery = arguments['search_query'];
      return SearchResultEventsScreen(
        searchQuery: searchQuery,
      );
    },
    formProposeEventRoute: (context) => const FormProposeEvent(),
    detailProfile: (context) {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return BlocProvider(
        create: (context) => UserBloc()
          ..add(FetchUserById(
              token: arguments['token'], userId: arguments['user_id'])),
        child: const HomeProfilePage(),
      );
    },
  };

  static Widget getHomeScreen(String? role) {
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
        return const SplashScreen(); // Fallback
    }
  }
}
