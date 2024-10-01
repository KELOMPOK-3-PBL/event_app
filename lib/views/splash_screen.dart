import 'package:flutter/material.dart';
import 'package:event_proposal_app/views/welcome_screen.dart'; // Pastikan import WelcomeScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();

    // Mulai animasi fade out setelah 2 detik dan selesai dalam 1 detik
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _opacity = 0.0; // Mengubah opacity menjadi 0 (fade out)
      });
    });

    // Setelah animasi selesai, navigasi ke WelcomeScreen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(), // Ganti ke screen berikutnya
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 1), // Durasi animasi fade out
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/logo.png', // Ganti dengan path gambar logo Anda
                width: 100, // Ubah ukuran sesuai kebutuhan
                height: 100,
              ),
              SizedBox(height: 20), // Jarak antara logo dan teks
              Text(
                'POLIVENT',
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff282A74),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
