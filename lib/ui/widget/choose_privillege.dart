// Fungsi untuk mengubah menampilkan pilihan privilage
import 'package:flutter/material.dart';

void choosePrivilege(BuildContext context, List<String> roles) {
  if (roles.isNotEmpty && roles.length == 1) {
    Navigator.of(context).restorablePushNamedAndRemoveUntil(
        '/', (Route<dynamic> route) => false,
        arguments: roles[0]);
  } else {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose Previlege"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: roles.map((role) {
              return ListTile(
                title: Text(role), // Display the role name
                onTap: () {
                  Navigator.restorablePushNamedAndRemoveUntil(
                      context, '/', (Route<dynamic> route) => false,
                      arguments: role); // Close the dialog
                },
              );
            }).toList(), // Convert the iterable to a list
          ),
        );
      },
    );
  }
}
