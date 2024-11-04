import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './data/provider/provider.dart';
import './ui/router/router.dart';
import './ui/theme/app_theme.dart';

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

  setupLocator();
  // final authRepository = AuthRepository();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(
    // MultiBlocProvider(
    //   providers: [
    //     BlocProvider(
    //       create: (context) =>
    //           AuthBloc(authRepository: authRepository)..add(AppStarted()),
    //     ),
    //   ],
    //   child:
    MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.buildTheme(Brightness.light),
      title: 'Polivent',
      routes: AppRoutes.routes,
      initialRoute: '/splash',
      // initialRoute: '/',
      // home: SplashScreen()
    );
  }
}
