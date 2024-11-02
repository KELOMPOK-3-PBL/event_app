import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uicons_pro/uicons_pro.dart';

import '../../bloc/bloc.dart';
import '../../data/repository/repository.dart';
import '../widget/ui_colors.dart';
import './home_superadmin_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool securePassword = true;
  bool rememberMe = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();

    _setupAnimations();

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
    context.read<AuthBloc>().add(AuthLoadRememberMe());

    final authState = context.read<AuthBloc>().state;
    if (authState is AuthRememberMeLoaded) {
      rememberMe = authState.rememberMe;
      _emailController.text = authState.email;
      _passwordController.text = authState.password;
    }
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _validatePassword(String password) {
    return password.length >= 5;
  }

  @override
  void dispose() {
    _animationController.dispose();
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Center(child: CircularProgressIndicator());
            },
          );
        } else if (state is AuthRememberMeLoaded) {
          _emailController.text = state.email;
          _passwordController.text = state.password;
          setState(() => rememberMe = state.rememberMe);
        } else if (state is AuthAuthenticated) {
          Navigator.of(context).pop(); // Close loading spinner
          print(state.payload?.roles);
          // if (state.payload!.roles.isNotEmpty) {}
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
                  BlocProvider<EventBloc>(
                      //! memanggil AuthBloc di dalam bloc EventBloc
                      create: (context) => EventBloc(
                          eventRepository: EventRepository(),
                          authBloc: AuthBloc())
                        ..add(EventFetched())),
                  BlocProvider<CategoryBloc>(
                      create: (context) =>
                          CategoryBloc(categoryRepository: StatusRepository())
                            ..add(CategoryReadData())),
                ],
                child: HomeSuperadminScreen(),
              ),
            ),
          );
        } else if (state is AuthUnauthenticated) {
          Navigator.of(context).pop(); // Close loading spinner
          _showError(context, state.message);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/background_login.png'), // Add a background image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            FadeTransition(
              opacity: _fadeAnimation,
              child: CustomScrollView(
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
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _emailController,
                                  focusNode: _emailFocusNode,
                                  cursorColor: UIColor.primary,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: UIColor.solidWhite,
                                    labelText: 'Email',
                                    errorText: _emailError,
                                    floatingLabelStyle: TextStyle(
                                        color: _emailFocusNode.hasFocus
                                            ? UIColor.primary
                                            : UIColor.typoGray),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: UIColor.primary),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: _emailFocusNode.hasFocus
                                              ? UIColor.primary
                                              : UIColor.typoGray),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: UIColor.rejected),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: UIColor.rejected),
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
                                TextFormField(
                                  controller: _passwordController,
                                  focusNode: _passwordFocusNode,
                                  obscureText: securePassword,
                                  cursorColor: UIColor.primary,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: UIColor.solidWhite,
                                    labelText: 'Password',
                                    errorText: _passwordError,
                                    floatingLabelStyle: TextStyle(
                                        color: _passwordFocusNode.hasFocus
                                            ? UIColor.primary
                                            : UIColor.typoGray),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: UIColor.primary),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: _passwordFocusNode.hasFocus
                                              ? UIColor.primary
                                              : UIColor.typoGray),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: UIColor.rejected),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: UIColor.rejected),
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
                                const SizedBox(height: 6.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Remember Me"),
                                    Switch(
                                      value: rememberMe,
                                      onChanged: (value) {
                                        setState(() => rememberMe = value);
                                      },
                                      activeColor: UIColor.primary,
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () =>
                                      _showForgotPasswordDialog(context),
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(color: Color(0xff1886EA)),
                                  ),
                                ),
                                const SizedBox(height: 12.0),
                                //! BLOC LISTENER for Button SIGN IN
                                ElevatedButton(
                                  onPressed: () {
                                    final email = _emailController.text.trim();
                                    final password =
                                        _passwordController.text.trim();

                                    if (email.isEmpty || password.isEmpty) {
                                      _showError(context,
                                          "Email and password cannot be empty.");
                                      return;
                                    }

                                    // Validasi input
                                    if (!_validateEmail(email)) {
                                      setState(() {
                                        _emailError =
                                            'Please enter a valid email address';
                                      });
                                      return;
                                    }

                                    if (!_validatePassword(password)) {
                                      setState(() {
                                        _passwordError =
                                            'Password must be at least 6 characters';
                                      });
                                      return;
                                    }

                                    context.read<AuthBloc>().add(
                                          AuthButtonPressed(
                                              email: email,
                                              password: password,
                                              rememberMe: rememberMe),
                                        );
                                    //! UNTUK MENGABAIKAN AUTENTIKASI - Route asli ada di BlocListener
                                    // Navigator.pushReplacement(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => MultiBlocProvider(
                                    //       providers: [
                                    //         BlocProvider<AuthBloc>(
                                    //             create: (context) =>
                                    //                 AuthBloc()),
                                    //         BlocProvider<EventBloc>(
                                    //             create: (context) => EventBloc(
                                    //                 eventRepository:
                                    //                     EventRepository(),
                                    //                 authBloc: AuthBloc())
                                    //               ..add(EventFetched())),
                                    //         BlocProvider<CategoryBloc>(
                                    //           create: (context) => CategoryBloc(
                                    //               categoryRepository:
                                    //                   StatusRepository())
                                    //             ..add(CategoryReadData()),
                                    //         ),
                                    //       ],
                                    //       child: HomeSuperadminScreen(),
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    backgroundColor: const Color(0xff1886EA),
                                  ),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.90,
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
