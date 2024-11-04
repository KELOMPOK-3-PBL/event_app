import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './data/provider/provider.dart';
import './ui/router/router.dart';
import './ui/theme/app_theme.dart';
import 'bloc/auth_bloc/auth_bloc.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarIconBrightness:
        Brightness.dark, // Menetapkan warna ikon status bar
    systemNavigationBarColor:
        Colors.transparent, // Menetapkan warna navigation bar
    statusBarColor: Colors.transparent, // Set the status bar color
  ));

  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();
  // final authRepository = AuthRepository();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //! Pengecekan apakah pernah login
      create: (context) => AuthBloc()..add(AuthAppStarted()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            print(state.authData.message);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.buildTheme(Brightness.light),
              title: 'Polivent',
              routes: AppRoutes.routes,
              initialRoute: '/',
            );
          } else if (state is AuthUnauthenticated) {
            print(state.message);

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.buildTheme(Brightness.light),
              title: 'Polivent',
              routes: AppRoutes.routes,
              initialRoute: '/splash',
            );
          }
          return Center();
        },
      ),
    );
  }
}
