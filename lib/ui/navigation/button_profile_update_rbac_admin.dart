import 'package:uicons_pro/uicons_pro.dart';
import 'package:flutter/material.dart';

import '../theme/ui_colors.dart';

class ButtonUpdateRBACAdmin extends StatelessWidget {
  final VoidCallback changeStatus;
  // final VoidCallback showEditNoteDialog;

  const ButtonUpdateRBACAdmin({
    super.key,
    required this.changeStatus,
    // required this.showEditNoteDialog,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UIColor.solidWhite,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            // flex: 5,
            child: ElevatedButton(
              onPressed: changeStatus,
              style: ElevatedButton.styleFrom(backgroundColor: UIColor.primary),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double fontSize = constraints.maxWidth *
                      0.057; // Ukuran font disesuaikan dengan lebar tombol
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        UIconsPro.regularRounded.book,
                        color: Colors.white,
                        size: fontSize + 1,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "Update Roles",
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: UIColor.solidWhite,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          // SizedBox(width: 8),
          // Expanded(
          //   flex: 4,
          //   child: ElevatedButton(
          //     onPressed: showEditNoteDialog,
          //     style:
          //         ElevatedButton.styleFrom(backgroundColor: UIColor.reviewing),
          //     child: LayoutBuilder(
          //       builder: (context, constraints) {
          //         double fontSize;
          //         if (constraints.maxWidth <= 1080) {
          //           fontSize = constraints.maxWidth *
          //               0.16; // Ukuran font disesuaikan dengan lebar tombol
          //         } else {
          //           fontSize = 16;
          //         }
          //         return Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Icon(
          //               UIconsPro.regularRounded.edit,
          //               color: Colors.white,
          //               size: fontSize + 1,
          //             ),
          //             SizedBox(width: 6),
          //             Text(
          //               "Edit Note",
          //               style: TextStyle(
          //                 fontSize: fontSize,
          //                 fontWeight: FontWeight.bold,
          //                 color: UIColor.solidWhite,
          //               ),
          //             ),
          //           ],
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
