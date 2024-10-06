import 'package:event_proposal_app/uikit/ui_colors.dart';
import 'package:event_proposal_app/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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
      brightness: brightness,
      textTheme: GoogleFonts.interTextTheme(
          ThemeData(brightness: brightness).textTheme),
      scaffoldBackgroundColor: UIColor.bgWhite,
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
