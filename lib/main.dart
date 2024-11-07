import 'package:event_proposal_app/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './data/provider/provider.dart';
import './ui/router/router.dart';
import './ui/theme/app_theme.dart';
import 'bloc/auth_bloc/auth_bloc.dart';
// import './ui/screen/login_screen.dart';
// import 'ui/router/go_router.dart';

Future<void> main() async {
  //! Make custom System Status bar, Navigation bar, etc
  const customSystemUiOverlayStyle = SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarIconBrightness:
        Brightness.dark, // Menetapkan warna ikon status bar
    systemNavigationBarColor:
        Colors.transparent, // Menetapkan warna navigation bar
    statusBarColor: Colors.transparent, // Set the status bar color
  );

  SystemChrome.setSystemUIOverlayStyle(customSystemUiOverlayStyle);

  // WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

//! Route baru (masih error)
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<AuthBloc>(
//       //! Pengecekan apakah pernah login
//       create: (context) => AuthBloc()..add(AuthAppStarted()),

//       child: BlocListener<AuthBloc, AuthState>(
//         listener: (context, state) {
//           if (state is AuthAuthenticated) {
//             print(state.authData.message);
//             print(state.authData.data!);

//             AppGoRoutes().router.goNamed("explore");
//           } else if (state is AuthUnauthenticated) {
//             AppGoRoutes().router.goNamed("splash");
//           }
//         },
//         child: MaterialApp.router(
//           routeInformationParser: AppGoRoutes().router.routeInformationParser,
//           routerDelegate: AppGoRoutes().router.routerDelegate,
//           routeInformationProvider:
//               AppGoRoutes().router.routeInformationProvider,
//           debugShowCheckedModeBanner: false,
//           theme: AppTheme.buildTheme(Brightness.light),
//           title: 'Polivent',
//         ),
//       ),
//     );
//   }
// }

  //! Route lama (jadi)
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      //! Pengecekan apakah pernah login
      create: (context) => AuthBloc()..add(AuthAppStarted()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            // Jika sudah terautentikasi, arahkan ke halaman utama
            return CustomMaterialApp(initialRoute: "/");
          } else if (state is AuthUnauthenticated) {
            // Jika belum login, arahkan ke halaman splash
            return CustomMaterialApp(initialRoute: "/welcome");
          }

          // Menampilkan indikator loading saat menunggu status autentikasi
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

//! Custom MaterialApp
class CustomMaterialApp extends StatelessWidget {
  final String initialRoute;
  const CustomMaterialApp({
    super.key,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.buildTheme(Brightness.light),
      title: 'Polivent',
      routes: AppRoutes.routes,
      initialRoute: initialRoute,
    );
  }
}
