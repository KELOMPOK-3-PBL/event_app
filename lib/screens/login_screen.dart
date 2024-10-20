import 'package:event_proposal_app/models_old/ui_colors.dart';
import 'package:event_proposal_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uicons_pro/uicons_pro.dart';
import '../blocs/login_bloc/login_bloc.dart';
import '../blocs/login_bloc/login_event.dart';
import '../blocs/login_bloc/login_state.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const Center(child: CircularProgressIndicator());
                },
              );
            } else if (state is LoginSuccess) {
              Navigator.of(context).pop(); // Close loading spinner
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            } else if (state is LoginFailure) {
              Navigator.of(context).pop(); // Close loading spinner
              _showError(context, state.error);
            } else if (state is ForgotPasswordState) {
              Navigator.of(context).pop(); // Close loading spinner
              _showForgotPasswordDialog(context);
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            return CustomScrollView(
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
                        _buildLoginTextField(
                            "Email",
                            UIconsPro.regularRounded.envelope,
                            _emailController,
                            _emailFocusNode,
                            false),
                        const SizedBox(height: 16.0),
                        _buildLoginTextField(
                            "Password",
                            UIconsPro.regularRounded.lock,
                            _passwordController,
                            _passwordFocusNode,
                            false),
                        const SizedBox(height: 8.0),
                        // BlocBuilder<LoginBloc, LoginState>(
                        //   builder: (context, state) {
                        //     return
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     const Text("Remember Me"),
                        //     Switch(
                        //       value: context.watch<LoginBloc>().rememberMe,
                        //       onChanged: (value) {
                        //         context.read<LoginBloc>().add(
                        //               RememberMeToggled(rememberMe: value),
                        //             );
                        //       },
                        //       activeColor: UIColor.primary,
                        //     ),
                        //   ],
                        //   // );
                        //   // },
                        // ),
                        TextButton(
                          onPressed: () {
                            context
                                .read<LoginBloc>()
                                .add(ForgotPasswordRequested());
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: Color(0xff1886EA)),
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        ElevatedButton(
                          onPressed: () {
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();

                            if (email.isEmpty || password.isEmpty) {
                              _showError(context,
                                  "Email and password cannot be empty.");
                              return;
                            }

                            context.read<LoginBloc>().add(
                                  LoginButtonPressed(
                                    email: email,
                                    password: password,
                                  ),
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
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
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

@override
Widget _buildLoginTextField(String label, IconData icon,
    TextEditingController controller, FocusNode focusMode, bool obscureText) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    focusNode: focusMode,
    cursorColor: UIColor.primary,
    decoration: InputDecoration(
      filled: true,
      fillColor: UIColor.solidWhite,
      labelText: label,
      floatingLabelStyle: TextStyle(
        color: focusMode.hasFocus ? UIColor.primary : UIColor.typoGray,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: UIColor.primary),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: focusMode.hasFocus ? UIColor.primary : UIColor.typoGray,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      // Change the icon color based on focus or input
      prefixIcon: Icon(
        icon,
        color: focusMode.hasFocus ? UIColor.primary : UIColor.typoGray,
      ),
    ),
  );
}
