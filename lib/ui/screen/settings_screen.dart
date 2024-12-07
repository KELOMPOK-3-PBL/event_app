// Suggested code may be subject to a license. Learn more: ~LicenseLog:3100013983.
import 'package:event_proposal_app/ui/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uicons_pro/uicons_pro.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../theme/ui_colors.dart';

class SettingsScreen extends StatefulWidget {
  // final List<String> roles;
  // final String currentRole;
  const SettingsScreen({
    super.key,
    //  required this.roles, required this.currentRole
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String>? roles;
  String? anotherRole;
  String? currentRole;
  String? userId;
  String? token;

  @override
  void initState() {
    super.initState();

    final state = context.read<AuthBloc>().state;
    debugPrint('State: ${state.toString()}');
    if (state is AuthAuthenticated) {
      currentRole = state.currentRole ?? '';
      roles = state.authData.data?.roles;
      userId = state.authData.data?.userId;
      token = state.authData.token;
      debugPrint('Current Role: ${state.currentRole.toString()}');
      currentRole = currentRole!;
      if (roles!.length != 1) {
        for (int i = 0; i < roles!.length; i++) {
          if (currentRole != roles?[i]) {
            anotherRole = roles?[i];
          }
        }
      }
      debugPrint('Roles: $roles');
      debugPrint('Another Role: $anotherRole');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(
          //         builder: (context) => const LoginScreen()),
          //     (Route<dynamic> route) => false);
          debugPrint('logout');
          Navigator.of(context).restorablePushNamedAndRemoveUntil(
              AppRouter.loginRoute, (Route<dynamic> route) => false);
        }
        // if (state is AuthAuthenticated) {
        //   debugPrint(state.toString());
        //   currentRole = state.currentRole!;
        //   if (state.authData.data!.roles.length != 1) {
        //     for (int i = state.authData.data!.roles.length; i == 2; i++) {
        //       if (currentRole != state.authData.data!.roles[i]) {
        //         anotherRole = state.authData.data!.roles[i];
        //       }
        //     }
        //   }
        // }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              UIconsPro.regularRounded.angle_small_left,
              // size: 20,
            ),
          ),
          automaticallyImplyLeading: false, // remove leading(left) back icon
          centerTitle: true,
          backgroundColor: UIColor.white,
          scrolledUnderElevation: 0,
          title: const Text(
            "Settings",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: UIColor.typoBlack,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            const SizedBox(height: 20.0),
            _buildSectionTitle(title: 'Account Settings'),
            _buildListTile(
              leadingIcon: UIconsPro.solidRounded.user,
              title: 'Edit Profile',
              trailingIcon: UIconsPro.solidRounded.angle_small_right,
              onTap: () {
                // Menunggu state di proses
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  // Setelah logout, arahkan pengguna ke halaman login
                  Navigator.of(context).pushNamed(
                    AppRouter.editProfile,
                    arguments: {
                      'token': token,
                      'user_id': userId,
                    },
                  );
                });
              },
            ),
            const SizedBox(height: 16.0),
            _buildSectionTitle(title: 'Preferences'),
            _buildListTile(
              leadingIcon: UIconsPro.solidRounded.notebook,
              title: 'About',
              trailingIcon: UIconsPro.solidRounded.angle_small_right,
              onTap: () {},
            ),
            _buildListTile(
              leadingIcon: UIconsPro.solidRounded.interrogation,
              title: 'Help',
              trailingIcon: UIconsPro.solidRounded.angle_small_right,
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const HelpScreen(),
                //   ),
                // );
              },
            ),
            const SizedBox(height: 20.0),
            if (anotherRole != null)
              _buildListTile(
                  leadingIcon: UIconsPro.regularRounded.sign_in_alt,
                  title: 'Sign in as ${anotherRole!}',
                  trailingIcon: null,
                  onTap: () {
                    switchUser(context, anotherRole!);
                  },
                  // titleColor: UIColor.reviewing,
                  leadingIconColor: UIColor.solidWhite,
                  titleColor: UIColor.solidWhite,
                  tileColor: UIColor.getRoleColor(anotherRole!)),
            const SizedBox(height: 6.0),
            _buildListTile(
                leadingIcon: UIconsPro.regularRounded.sign_out_alt,
                title: 'Sign Out',
                onTap: () {
                  showLogoutBottomSheet(context);
                },
                titleColor: UIColor.solidWhite,
                leadingIconColor: UIColor.solidWhite,
                tileColor: UIColor.rejected),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData leadingIcon,
    required String title,
    IconData? trailingIcon,
    required VoidCallback onTap,
    Color? titleColor,
    Color? leadingIconColor,
    Color? trailingIconColor,
    Color? tileColor,
    Size? iconSize,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        // Buat background berwarna putih
        tileColor: tileColor ?? UIColor.solidWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),

        leading: Icon(
          leadingIcon,
          color: leadingIconColor ?? Colors.grey,
          size: iconSize?.width ?? 24.0,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: titleColor ?? Colors.black,
          ),
        ),
        trailing: trailingIcon != null
            ? Icon(
                trailingIcon,
                color: trailingIconColor ?? Colors.grey,
                size: iconSize?.width ?? 16.0,
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}

void showLogoutBottomSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: UIColor.solidWhite,
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Sign out',
              style: TextStyle(color: UIColor.rejected, fontSize: 24),
            ),
            Divider(
              height: 48,
              color: Colors.grey[300],
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
            // const SizedBox(height: 16),
            const Text(
              'Are you sure you want to sign out?\n'
              'You can always sign back to explore more\n'
              'events and stay updated!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 50),
                    // padding: const EdgeInsets.symmetric(
                    //     horizontal: 50, vertical: 20),
                    backgroundColor: Colors
                        .grey[200], // Set Cancel button background to grey 200
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: UIColor.typoBlack),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Tambahkan logika logout di sini, misalnya:
                    // FirebaseAuth.instance.signOut();
                    context.read<AuthBloc>().add(
                          AuthLogoutRequest(),
                        );

                    // Setelah logout, arahkan pengguna ke halaman login
                    // Navigator.of(context).pushAndRemoveUntil(
                    //     MaterialPageRoute(
                    //         builder: (context) => const LoginScreen()),
                    //     (Route<dynamic> route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 50),
                    // padding: const EdgeInsets.symmetric(
                    //     horizontal: 50, vertical: 20),
                    backgroundColor: Colors
                        .blue, // Set Yes, Sign out button background to blue
                  ),
                  child: const Text(
                    'Yes, sign out',
                    style: TextStyle(
                        color: Colors
                            .white), // You might want to change text color to white for better contrast
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

void switchUser(BuildContext context, String anotherRole) {
  showModalBottomSheet(
    backgroundColor: UIColor.solidWhite,
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Login as $anotherRole',
              style: TextStyle(
                  color: UIColor.getRoleColor(anotherRole), fontSize: 24),
            ),
            Divider(
              height: 10,
              color: Colors.grey[300],
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
            const SizedBox(height: 12),
            Text(
              'Are you sure you want to login as $anotherRole?\n'
              // 'You can always sign back to explore more\n'
              // 'events and stay updated!'
              ,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            // const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 50),
                    // padding: const EdgeInsets.symmetric(
                    //     horizontal: 50, vertical: 20),
                    backgroundColor: Colors
                        .grey[200], // Set Cancel button background to grey 200
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: UIColor.typoBlack),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<AuthBloc>()
                        .add(AuthSaveCurrentRole(currentRole: anotherRole));
                    // Menunggu state di proses
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      // Setelah logout, arahkan pengguna ke halaman login
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRouter.homeRoute, (Route<dynamic> route) => false,
                          arguments: anotherRole);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 50),
                    // padding: const EdgeInsets.symmetric(
                    //     horizontal: 50, vertical: 20),
                    backgroundColor: UIColor.getRoleColor(
                        anotherRole), //getRoleColor(anotherRole) Set Yes, Sign out button background to blue
                  ),
                  child: const Text(
                    'Yes, switch',
                    style: TextStyle(
                        color: Colors
                            .white), // You might want to change text color to white for better contrast
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
