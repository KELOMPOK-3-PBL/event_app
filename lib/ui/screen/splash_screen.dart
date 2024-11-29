import 'package:flutter/material.dart';
import 'package:event_proposal_app/ui/router/router.dart'; // Pastikan file router sudah sesuai

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  double _opacity = 1.0; // Opacity awal
  late final Future<void> fadeOutFuture; // Mengelola future untuk animasi

  @override
  void initState() {
    super.initState();

    // Memulai animasi fade out
    fadeOutFuture = _startFadeOut();
  }

  Future<void> _startFadeOut() async {
    // Tunggu 2 detik sebelum memulai animasi fade out
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return; // Cek jika widget masih mounted
    setState(() {
      _opacity = 0.0; // Fade out dengan mengubah opacity
    });

    // Tunggu animasi selesai (1 detik) sebelum navigasi
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return; // Cek jika widget masih mounted
    _navigateToWelcome();
  }

  void _navigateToWelcome() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRouter.welcomeRoute,
      (Route<dynamic> route) => false,
    );
  }

  @override
  void dispose() {
    // Pastikan semua proses asynchronous dihentikan jika widget disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 1), // Durasi animasi fade out
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/images/logo.png', // Pastikan path logo benar
                width: 200, // Ukuran logo
                height: 200,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.error,
                  size: 50,
                  color: Colors.red,
                ), // Handle error jika gambar tidak ditemukan
              ),
              const SizedBox(height: 20), // Jarak antara logo dan teks
              const Text(
                'POLIVENT',
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.w700,
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
