import 'package:event_proposal_app/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import '../screen/detail_account_screen.dart';
import '../screen/detail_event_approval_propose_screen.dart';
import '../screen/detail_event_for_join_screen.dart';
import '../screen/edit_profile_screen.dart';
import '../screen/form_propose_event.dart';
import '../screen/home_admin_screen.dart';
import '../screen/home_member_screen.dart';
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
  // static const String detailEventProposeRoute = '/detail_event_propose';
  static const String detailEventApprovalProposeRoute =
      '/detail_event_approval_propose';
  static const String searchResultEventRoute = '/search_result_event';
  static const String formProposeEventRoute = '/form_propose_event';
  static const String detailAccount = '/detail_account';
  static const String editProfile = '/edit_profile';

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
          },
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
    settingsRoute: (context) {
      return BlocProvider.value(
        value: context.read<AuthBloc>(),
        child: SettingsScreen(),
      );
    },
    detailEventRoute: (context) {
      // final EventDataModel arguments =
      //     ModalRoute.of(context)!.settings.arguments as EventDataModel;
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final EventDataModel eventData = arguments['event_data'];
      // final String currentRole = arguments['current_role'];
      return DetailEventScreen(data: eventData);
    },
    detailEventApprovalProposeRoute: (context) {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final EventDataModel eventData = arguments['event_data'];
      final String currentRole = arguments['current_role'];
      debugPrint(arguments.toString());
      return DetailEventApprovalProposeScreen(
        eventData: eventData,
        currentRole: currentRole,
      );
    },
    searchResultEventRoute: (context) {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      String? searchQuery = arguments['search_query'];
      String? categoryName = arguments['category_name'];
      return SearchResultEventsScreen(
        searchQuery: searchQuery ?? categoryName!,
      );
    },
    formProposeEventRoute: (context) => MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: context.read<AuthBloc>(),
            ),
            BlocProvider(
              create: (context) => CategoryBloc()..add(CategoryReadData()),
            ),
            BlocProvider(
              create: (context) => EventBloc(),
            ),
          ],
          child: FormProposeEvent(),
        ),
    detailAccount: (context) {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return BlocProvider(
        create: (context) => UserBloc()
          ..add(FetchUserById(
              token: arguments['token'], userId: arguments['user_id'])),
        child: const DetailAccountScreen(),
      );
    },
    editProfile: (context) {
      final Map<String, dynamic> arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return BlocProvider(
        create: (context) => UserBloc()
          ..add(FetchUserById(
              token: arguments['token'], userId: arguments['user_id'])),
        child: EditProfileScreen(),
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
        return const HomeMemberScreen();
      default:
        return const SplashScreen(); // Fallback
    }
  }
}
