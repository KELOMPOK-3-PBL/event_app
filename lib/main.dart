import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './data/provider/provider.dart';
import './ui/router/router.dart';
import './ui/theme/app_theme.dart';
import 'bloc/auth_bloc/auth_bloc.dart';

Future<void> main() async {
  //! Make custom System Status bar, Navigation bar, etc
  const customSystemUiOverlayStyle = SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarIconBrightness:
        Brightness.dark, // Menetapkan warna ikon status bar
    systemNavigationBarColor:
        Colors.transparent, // Menetapkan warna navigation bar
    statusBarColor: Colors.transparent, // Set the status bar color
  );

  SystemChrome.setSystemUIOverlayStyle(customSystemUiOverlayStyle);

  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      //! Pengecekan apakah pernah login
      create: (context) => AuthBloc()..add(AuthAppStarted()),
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is AuthAuthenticated) {
          print(state.authData.message);
          return CustomMaterialApp(
            initialRoute: "/",
          );
        } else if (state is AuthUnauthenticated) {
          return CustomMaterialApp(
            initialRoute: "/splash",
          );
        }
        // Menangani state lain jika perlu
        return Center(
            child: CircularProgressIndicator()); // Atau widget loading
      }),
    );
  }
}

//! Custom MaterialApp
class CustomMaterialApp extends StatelessWidget {
  final String initialRoute;
  const CustomMaterialApp({
    super.key,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.buildTheme(Brightness.light),
      title: 'Polivent',
      routes: AppRoutes.routes,
      initialRoute: initialRoute,
    );
  }
}
