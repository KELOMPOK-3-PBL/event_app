import 'package:event_proposal_app/models/ui_colors.dart';
import 'package:event_proposal_app/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness:
        Brightness.dark, // Menetapkan warna ikon status bar
    systemNavigationBarColor:
        Colors.transparent, // Menetapkan warna navigation bar
    statusBarColor: Colors.transparent, // Set the status bar color
  ));
  runApp(const MyApp());
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
      home: const SplashScreen(),
    );
  }
}
