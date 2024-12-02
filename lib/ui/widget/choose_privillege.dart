import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../router/router.dart';
import '../theme/ui_colors.dart';

class PrivilegeDialog {
  // Method to show the privilege selection dialog
  static void showChoosePrivilegeDialog(
      BuildContext context, List<String> roles) {
    if (roles.isEmpty) {
      return; // No roles to display
    }
    if (roles.length == 1) return _navigateToHome(context, roles[0]);

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Choose Privilege",
            textAlign: TextAlign.center,
          ),
          content: _buildRoleList(roles, context),
        );
      },
    );
  }

  // Helper method to build the list of roles
  static Widget _buildRoleList(List<String> roles, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: roles.map((role) => _buildRoleTile(role, context)).toList(),
      ),
    );
  }

  // Helper method to create a ListTile for each role
  static Widget _buildRoleTile(String role, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: UIColor.getRoleColor(role),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        textColor: UIColor.solidWhite,
        title: Text(
          role,
          textAlign: TextAlign.center,
        ),
        onTap: () => _navigateToHome(context, role),
      ),
    );
  }

  // Navigate to home with the selected role
  static void _navigateToHome(BuildContext context, String role) {
    // Implement navigation logic here
    // Navigator.pop(context); // Close the dialog
    // Navigate to home with the selected role
    context.read<AuthBloc>().add(AuthSaveCurrentRole(currentRole: role));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRouter.homeRoute,
        (Route<dynamic> route) => false,
        arguments: role,
      );
    });
  }
}
