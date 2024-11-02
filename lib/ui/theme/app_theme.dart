import 'package:flutter/material.dart';
import '../widget/ui_colors.dart'; // Adjust the import based on your project structure

class AppTheme {
  static ThemeData buildTheme(Brightness brightness) {
    return ThemeData(
      splashFactory: NoSplash.splashFactory, // Remove splash effect on navbar
      highlightColor: Colors.transparent, // Remove highlight color on navbar
      fontFamily: "Inter",
      brightness: brightness,
      textTheme: (ThemeData(brightness: brightness).textTheme),
      scaffoldBackgroundColor: UIColor.white,
    );
  }
}
