import 'package:event_proposal_app/ui/section/detail_profile_content_section.dart';
import 'package:event_proposal_app/ui/theme/ui_colors.dart';
import 'package:event_proposal_app/ui/widget/show_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uicons_pro/uicons_pro.dart';

import '../../bloc/user_bloc/user_bloc.dart';
import '../navigation/button_profile_update_rbac_admin.dart';

class DetailAccountScreen extends StatefulWidget {
  const DetailAccountScreen({super.key});

  @override
  State<DetailAccountScreen> createState() => _HomeProfile();
}

class _HomeProfile extends State<DetailAccountScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<int> currentRole = [];

  final Map<String, int> roleMapping = {
    "Member": 1,
    "Propose": 2,
    "Admin": 3,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColor.white,
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserByUIDLoaded) {
            for (var role in state.userData.roles!) {
              if (!currentRole.contains(roleMapping[role]!)) {
                // currentRole.add(roleMapping[role]!);
                currentRole.add(roleMapping[role]!);
              }
            }
          }
        },
        builder: (context, state) {
          return BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserByUIDLoaded) {
                return Column(
                  children: [
                    AppBar(
                      leading: IconButton(
                        icon: Icon(
                          UIconsPro.regularRounded.angle_small_left,
                          size: 17,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),

                      automaticallyImplyLeading:
                          false, // remove leading(left) back icon
                      centerTitle: true,
                      backgroundColor: UIColor.solidWhite,
                      scrolledUnderElevation: 0,
                      title: Text(
                        "Account Profile",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: UIColor.typoBlack,
                        ),
                      ),
                    ),
                    DetailProfileContentSection(userData: state.userData),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
      bottomNavigationBar: ButtonUpdateRBACAdmin(
        changeStatus: () {
          // selectedRoles = currentRole;
          final List<int> selectedRoles = currentRole;

          showModalBottomSheet(
            backgroundColor: UIColor.solidWhite,
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (BuildContext context) {
              String? errorMessage;
              debugPrint("selected ${selectedRoles.toString()}");

              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter modalSetState) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Change Role',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.grey.shade300,
                            child: Text(
                              '${selectedRoles.length}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Display error message if exists
                      if (errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            errorMessage!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      Flex(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        direction: Axis.horizontal,
                        children: roleMapping.keys.map((roleName) {
                          return _roleButton(
                            roleName,
                            selectedRoles.contains(roleMapping[roleName]!)
                                ? UIColor.getRoleColor(roleName)
                                : Colors.grey.shade300,
                            // textColor:
                            selectedRoles.contains(roleMapping[roleName]!)
                                ? Colors.white
                                : Colors.black,
                            modalSetState,
                            selectedRoles,
                          );
                        }).toList(),
                        //     roleMapping.keys.map((roleName) {
                        //   return _roleButton(
                        //     roleName,
                        //     selectedRoles.contains(roleMapping[roleName]!)
                        //         ? Colors.blue
                        //         : Colors.grey.shade300,
                        //     textColor:
                        //         selectedRoles.contains(roleMapping[roleName]!)
                        //             ? Colors.white
                        //             : Colors.black,
                        //   );
                        // }).toList(),
                      ),
                      SizedBox(height: 24),
                      Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // if (selectedRoles.isEmpty) {
                              //   modalSetState(() {
                              //     // Simulate another error
                              //     errorMessage = "Select at least one role.";
                              //   });
                              // } else {
                              Navigator.of(context)
                                  .pop(); // Close the bottom sheet
                              // }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(150, 50),
                              // padding: const EdgeInsets.symmetric(
                              //     horizontal: 50, vertical: 20),
                              backgroundColor: UIColor
                                  .typoGray2, // Set Cancel button background to grey 200
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                  color: UIColor.typoBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          // _actionButton(
                          //     'Cancel', Colors.grey.shade300, Colors.black, () {
                          //   Navigator.pop(context);
                          // }),
                          ElevatedButton(
                            onPressed: () {
                              if (selectedRoles.isEmpty) {
                                modalSetState(() {
                                  // Simulate another error
                                  errorMessage = "Select at least one role.";
                                });
                              } else {
                                Navigator.of(context)
                                    .pop(); // Close the bottom sheet
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(150, 50),
                              // padding: const EdgeInsets.symmetric(
                              //     horizontal: 50, vertical: 20),
                              backgroundColor: Colors
                                  .blue, // Set Yes, Sign out button background to blue
                            ),
                            child: const Text(
                              'Confirm',
                              style: TextStyle(
                                  color: UIColor.solidWhite,
                                  fontWeight: FontWeight
                                      .bold), // You might want to change text color to white for better contrast
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
            },
          );
        },
      ),
    );
  }

  Widget _roleButton(String text, Color color, Color textColor,
      StateSetter modalSetState, List<int> selectedRoles) {
    return ElevatedButton(
      onPressed: () {
        int roleId = roleMapping[text]!;
        modalSetState(() {
          if (selectedRoles.contains(roleId)) {
            selectedRoles.remove(roleId);
          } else {
            selectedRoles.add(roleId);
          }
        });
        setState(() {}); // Update the main UI as well
        debugPrint("selected ${selectedRoles.toString()}");
        // debugPrint("current ${currentRole.toString()}");
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  // Widget _actionButton(
  //     String text, Color backgroundColor, Color textColor, VoidCallback onTap) {
  //   return ElevatedButton(
  //     onPressed: onTap,
  //     style: ElevatedButton.styleFrom(
  //       foregroundColor: textColor,
  //       backgroundColor: backgroundColor,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
  //     ),
  //     child: Text(
  //       text,
  //       style: TextStyle(fontSize: 16),
  //     ),
  //   );
  // }

  @override
  void dispose() {
    super.dispose();
  }
}
