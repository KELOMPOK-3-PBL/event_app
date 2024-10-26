import 'package:event_proposal_app/presentation/screen/splash_screen.dart';
import 'package:event_proposal_app/presentation/widget/ui_colors.dart';
// import 'package:event_proposal_app/presentation/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/bloc.dart';
import 'data/repository/repository.dart';
import 'presentation/screen/home_superadmin_screen.dart';
import 'presentation/screen/login_screen.dart';
import 'presentation/screen/welcome_screen.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
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
  ThemeData _buildTheme(Brightness brightness) {
    return ThemeData(
      splashFactory: NoSplash
          .splashFactory, //! Hilangkan splash effect  saat menekan navbar
      highlightColor:
          Colors.transparent, //! Hilangkan highlight color saat menekan navbar
      fontFamily: "Inter",
      brightness: brightness,
      textTheme: (ThemeData(brightness: brightness).textTheme),
      scaffoldBackgroundColor: UIColor.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _buildTheme(Brightness.light),
        title: 'Polivent',
        home: SplashScreen()
        // BlocConsumer<AuthBloc, AuthState>(
        //   listener: (context, state) {
        //     if (state is AuthSessionExpired) {
        //       // Tampilkan dialog atau arahkan ke halaman login saat sesi habis
        //       Navigator.pushReplacement(
        //         context,
        //         MaterialPageRoute(builder: (context) => WelcomeScreen()),
        //       );
        //     }
        //   },
        //   builder: (context, state) {
        //     if (state is AuthAuthenticated) {
        //       return HomeSuperadminScreen();
        //     } else if (state is AuthUnauthenticated) {
        //       return LoginScreen();
        //     }
        //     return Center(child: CircularProgressIndicator());
        //   },
        // ),
        );
  }
}
