import 'package:flutter/material.dart';
import 'ui_colors.dart'; // Adjust the import based on your project structure

class AppTheme {
  static ThemeData buildTheme(Brightness brightness) {
    return ThemeData(
      primaryColor: UIColor.primary,
      shadowColor: UIColor.shadowColor,
      snackBarTheme: SnackBarThemeData(
        // backgroundColor: const Color.fromARGB(221, 41, 41, 41),
        backgroundColor: UIColor.typoGray,
        // behavior: SnackBarBehavior.floating,
      ),
      focusColor: UIColor.primary,
      // hintColor: UIColor.typoGray,
      splashFactory: NoSplash.splashFactory, // Remove splash effect on navbar
      highlightColor: Colors.transparent, // Remove highlight color on navbar
      fontFamily: "Inter",
      brightness: brightness,
      textTheme: (ThemeData(brightness: brightness).textTheme),
      scaffoldBackgroundColor: UIColor.white,
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ButtonStyle(
      //         textStyle: WidgetStatePropertyAll(TextStyle(
      //             fontFamily: "Inter", fontWeight: FontWeight.w800))))
    );
  }
}
