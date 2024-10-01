import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false; // Variabel untuk slide button "Remember Me"
  final FocusNode emailFocusNode = FocusNode(); // Fokus untuk TextField email
  final FocusNode passwordFocusNode =
      FocusNode(); // Fokus untuk TextField password

  @override
  void initState() {
    super.initState();
    emailFocusNode.addListener(() {
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
          SliverAppBar(
            floating: false, // Membuat AppBar floating
            pinned: true, // Menjaga AppBar tetap terlihat
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Polivent",
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff282A74),
                    ),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Field input untuk email
                  TextField(
                    controller: emailController,
                    focusNode: emailFocusNode, // Mengaitkan FocusNode
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      labelStyle: TextStyle(color: Colors.black),
                      floatingLabelStyle: TextStyle(color: Colors.blue),
                      prefixIcon: Icon(
                        Icons.email,
                        color: emailFocusNode.hasFocus
                            ? Colors.blue // Warna saat fokus
                            : Colors.black38, // Warna saat tidak fokus
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Field input untuk password
                  TextField(
                    controller: passwordController,
                    focusNode: passwordFocusNode, // Mengaitkan FocusNode
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      labelStyle: TextStyle(color: Colors.black),
                      floatingLabelStyle: TextStyle(color: Colors.blue),
                      prefixIcon: Icon(Icons.lock, color: Colors.black38),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  // Slide button "Remember Me"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Remember Me"),
                      Switch(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value;
                          });
                        },
                        activeColor: Color(0xff1886EA),
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
                            title: Text("Forgot Password?"),
                            content:
                                Text("Reset password functionality goes here."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text("Forgot Password?",
                        style: TextStyle(color: Color(0xff1886EA))),
                  ),
                  SizedBox(height: 24.0),
                  // Tombol Login
                  ElevatedButton(
                    onPressed: () {
                      String email = emailController.text;
                      String password = passwordController.text;

                      // Navigasi ke halaman berikutnya jika login berhasil
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 130.0, vertical: 13.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: Color(0xff1886EA),
                    ),
                    child: Text("Sign in",
                        style: TextStyle(fontSize: 18.0, color: Colors.white)),
                  ),
                  SizedBox(height: 16.0),
                  Text("OR",
                      style: TextStyle(fontSize: 18, color: Colors.black38)),
                  SizedBox(height: 16.0),
                  // Sign In with Google button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 13.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: Colors.white70,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/google_logo.png', height: 20),
                        SizedBox(width: 8.0),
                        Text("Sign In with Google",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black)),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Link untuk pendaftaran
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
                    child: Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(
                        color: Color(0xff1886EA),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Center(
        child: Text('This is the signup screen.'),
      ),
    );
  }
}
