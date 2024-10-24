// import 'package:event_proposal_app/bloc/auth_bloc/auth_event.dart';
import 'package:event_proposal_app/bloc/category_bloc/category_bloc.dart';
import 'package:event_proposal_app/data/repositories/category_repository.dart';
import 'package:event_proposal_app/presentation/widget/ui_colors.dart';
import 'package:event_proposal_app/presentation/screen/home_superadmin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uicons_pro/uicons_pro.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/auth_bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool securePassword = true;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();

    // Listener for when the text fields lose or gain focus
    _emailFocusNode.addListener(() {
      setState(() {}); // To update the UI when focus changes
    });

    _passwordFocusNode.addListener(() {
      setState(() {}); // To update the UI when focus changes
    });

    // Listener for text input
    _emailController.addListener(() {
      setState(() {}); // Update the UI when text changes
    });

    _passwordController.addListener(() {
      setState(() {}); // Update the UI when text changes
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  showhide() {
    setState(() {
      securePassword = !securePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
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
                  TextField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    cursorColor: UIColor.primary,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: UIColor.solidWhite,
                      labelText: 'Email',
                      floatingLabelStyle: TextStyle(
                          color: _emailFocusNode.hasFocus
                              ? UIColor.primary
                              : UIColor.typoGray),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: UIColor.primary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: _emailFocusNode.hasFocus
                                ? UIColor.primary
                                : UIColor.typoGray),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(
                        UIconsPro.regularRounded.envelope,
                        color: _emailFocusNode.hasFocus
                            ? UIColor.primary
                            : UIColor.typoGray,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    obscureText: securePassword,
                    cursorColor: UIColor.primary,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: UIColor.solidWhite,
                      labelText: 'Password',
                      floatingLabelStyle: TextStyle(
                          color: _passwordFocusNode.hasFocus
                              ? UIColor.primary
                              : UIColor.typoGray),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: UIColor.primary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: _passwordFocusNode.hasFocus
                                ? UIColor.primary
                                : UIColor.typoGray),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(
                        UIconsPro.regularRounded.lock,
                        color: _passwordFocusNode.hasFocus
                            ? UIColor.primary
                            : UIColor.typoGray,
                      ),
                      suffixIcon: IconButton(
                          color: _passwordFocusNode.hasFocus
                              ? UIColor.primary
                              : UIColor.typoGray,
                          onPressed: () {
                            showhide();
                          },
                          icon: Icon(securePassword
                              ? UIconsPro.solidRounded.eye_crossed
                              : UIconsPro.solidRounded.eye)),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Remember Me"),
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                        activeColor: UIColor.primary,
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      _showForgotPasswordDialog(context);
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Color(0xff1886EA)),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  //! BLOC LISTENER for Button SIGN IN
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLoading) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        );
                      } else if (state is AuthSuccess) {
                        Navigator.of(context).pop(); // Close loading spinner
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => AuthBloc(),
                              child: HomeSuperadmin(),
                            ),
                          ),
                        );
                      } else if (state is AuthFailure) {
                        Navigator.of(context).pop(); // Close loading spinner
                        _showError(context, state.error);
                      }
                    },
                    child: ElevatedButton(
                      onPressed: () {
                        // final email = _emailController.text.trim();
                        // final password = _passwordController.text.trim();

                        // if (email.isEmpty || password.isEmpty) {
                        //   _showError(
                        //       context, "Email and password cannot be empty.");
                        //   return;
                        // }
                        // context.read<AuthBloc>().add(
                        //       SignInButtonPressed(
                        //         email: email,
                        //         password: password,
                        //       ),
                        //     );
                        //! UNTUK MENGABAIKAN AUTENTIKASI
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                // MultiBlocProvider(
                                //   providers: [
                                //     BlocProvider(create: (context) => AuthBloc()),
                                //     // RepositoryProvider<CategoryRepository>(
                                //     //     create: (context) => CategoryBloc()),
                                //   ],
                                // child:
                                HomeSuperadmin(),
                          ),
                          // ),
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
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: const Text(
                          "Sign in",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
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

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Forgot Password?"),
          content: const Text("Reset password functionality goes here."),
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
  }
}
