import 'package:event_proposal_app/models/ui_colors.dart';
import 'package:event_proposal_app/views/home_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import 'package:uicons_pro/uicons_pro.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false; // Variabel untuk slide button "Remember Me"
  final FocusNode emailFocusNode = FocusNode(); // Fokus untuk TextField email
  final FocusNode passwordFocusNode =
      FocusNode(); // Fokus untuk TextField password
  String email = "";
  String password = "";
  @override
  void initState() {
    super.initState();
    emailFocusNode.addListener(() {
      setState(() {}); // Memperbarui tampilan saat fokus berubah
    });
    passwordFocusNode.addListener(() {
      setState(() {}); // Memperbarui tampilan saat fokus berubah
    });
  }

  @override
  void dispose() {
    emailFocusNode.dispose(); // Bersihkan FocusNode saat tidak digunakan
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        // Menggunakan CustomScrollView untuk dapat scroll
        slivers: [
          // const SliverAppBar(
          //   floating: false, // Membuat AppBar floating
          //   pinned: true, // Menjaga AppBar tetap terlihat
          // ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  Image.asset(
                    'assets/logo.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "POLIVENT",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff282A74),
                    ),
                  ),
                  const SizedBox(height: 55),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: UIColor.typoBlack,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Field input untuk email
                  TextField(
                    // style: const TextStyle(color: UIColor.solidWhite),
                    controller: emailController,
                    focusNode: emailFocusNode, // Mengaitkan FocusNode
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: UIColor.solidWhite,
                      labelText: 'Email',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: UIColor.primary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: UIColor.typoGray),
                          borderRadius: BorderRadius.circular(12)),
                      labelStyle: const TextStyle(
                          color: UIColor.typoGray, fontSize: 14),
                      floatingLabelStyle:
                          const TextStyle(color: UIColor.primary),
                      prefixIcon: Icon(
                        UIconsPro.regularRounded.envelope,
                        size: 20,
                        color: emailFocusNode.hasFocus
                            ? UIColor.primary // Warna saat fokus
                            : UIColor.typoGray, // Warna saat tidak fokus
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Field input untuk password
                  TextField(
                    controller: passwordController,
                    focusNode: passwordFocusNode, // Mengaitkan FocusNode
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: UIColor.solidWhite,
                      labelText: 'Password',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: UIColor.primary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: UIColor.typoGray),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelStyle: const TextStyle(
                          color: UIColor.typoGray, fontSize: 14),
                      floatingLabelStyle:
                          const TextStyle(color: UIColor.primary),
                      prefixIcon: Icon(
                        UIconsPro.regularRounded.lock,
                        size: 20,
                        color: passwordFocusNode.hasFocus
                            ? UIColor.primary // Warna saat fokus
                            : UIColor.typoGray, // Warna saat tidak fokus
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Slide button "Remember Me"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Remember Me"),
                      Switch(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value;
                          });
                        },
                        activeColor: UIColor.primary,
                      ),
                    ],
                  ),

                  // Link "Forgot Password?"
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Forgot Password?"),
                            content: const Text(
                                "Reset password functionality goes here."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text("Forgot Password?",
                        style: TextStyle(color: Color(0xff1886EA))),
                  ),
                  const SizedBox(height: 24.0),
                  // Tombol Login
                  ElevatedButton(
                    onPressed: () {
                      email = emailController.text;
                      password = passwordController.text;

                      // Navigasi ke halaman berikutnya jika login berhasil
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: const Color(0xff1886EA),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.90, // Set the width to 90% of the screen width
                      child: const Text("Sign in",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 18.0, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Screen'),
//       ),
//       body: const Center(
//         child: Text('Welcome to the Home Screen!'),
//       ),
//     );
//   }
// }

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: const Center(
        child: Text('This is the signup screen.'),
      ),
    );
  }
}
