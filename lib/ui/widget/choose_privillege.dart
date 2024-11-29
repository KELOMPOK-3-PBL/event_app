import 'package:event_proposal_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../router/router.dart';

class ChoosePrivilegeDialog extends StatelessWidget {
  final List<String> roles;

  const ChoosePrivilegeDialog({
    super.key,
    required this.roles,
  });

  void _navigateToHome(BuildContext context, String role) {
    context.read<AuthBloc>().add(AuthSaveCurrentRole(currentRole: role));
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRouter.homeRoute,
      (Route<dynamic> route) => false,
      arguments: role,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (roles.isEmpty) {
      // Jika tidak ada role, tidak menampilkan apapun
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop(); // Menutup dialog jika tidak ada role
      });
      return const SizedBox.shrink();
    }

    if (roles.length == 1) {
      // Jika hanya ada satu role, langsung navigasi ke home
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigateToHome(context, roles[0]);
      });
      return const SizedBox.shrink();
    }

    // Tampilkan dialog jika ada lebih dari satu role
    return AlertDialog(
      title: const Text("Choose Privilege"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: roles.map((role) {
          return ListTile(
            title: Text(role),
            onTap: () => _navigateToHome(context, role),
          );
        }).toList(),
      ),
    );
  }
}

// Cara memanggil widget ini:
void showChoosePrivilegeDialog(BuildContext context, List<String> roles) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return ChoosePrivilegeDialog(roles: roles);
    },
  );
}
