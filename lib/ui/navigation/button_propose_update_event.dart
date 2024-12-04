import 'package:uicons_pro/uicons_pro.dart';
import 'package:flutter/material.dart';

import '../theme/ui_colors.dart';

class ButtonProposeUpdateEvent extends StatelessWidget {
  final VoidCallback changeStatus;
  final VoidCallback showEditNoteDialog;

  const ButtonProposeUpdateEvent({
    super.key,
    required this.changeStatus,
    required this.showEditNoteDialog,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: UIColor
                    .shadowColor, // Ganti UIColor.shadowColor dengan warna yang sesuai
                blurRadius: 10.0, // Sesuaikan nilai blurRadius
                offset: Offset(0, 4), // Sesuaikan nilai offset
              ),
            ],
            color: UIColor.solidWhite,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    // flex: 5,
                    child: ElevatedButton(
                      onPressed: changeStatus,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: UIColor.admin),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double fontSize = constraints.maxWidth *
                              0.057; // Ukuran font disesuaikan dengan lebar tombol
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                UIconsPro.regularRounded.qrcode,
                                color: Colors.white,
                                size: fontSize + 1,
                              ),
                              SizedBox(width: 6),
                              Text(
                                "Attendance QR",
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
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: ElevatedButton(
                      onPressed: changeStatus,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: UIColor.reviewing),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double fontSize = constraints.maxWidth *
                              0.12; // Ukuran font disesuaikan dengan lebar tombol
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                UIconsPro.regularRounded.edit,
                                color: Colors.white,
                                size: fontSize + 1,
                              ),
                              SizedBox(width: 6),
                              Text(
                                "Edit Event",
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
                  SizedBox(width: 6),
                  Expanded(
                    flex: 4,
                    child: ElevatedButton(
                      onPressed: showEditNoteDialog,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: UIColor.primary),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double fontSize;
                          if (constraints.maxWidth <= 1080) {
                            fontSize = constraints.maxWidth *
                                0.16; // Ukuran font disesuaikan dengan lebar tombol
                          } else {
                            fontSize = 16;
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                UIconsPro.regularRounded.address_book,
                                color: Colors.white,
                                size: fontSize + 1,
                              ),
                              SizedBox(width: 6),
                              Text(
                                "Invite",
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
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
