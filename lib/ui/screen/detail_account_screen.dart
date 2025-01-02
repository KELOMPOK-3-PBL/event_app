import 'package:event_proposal_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:event_proposal_app/data/model/model.dart';
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

  late UserDataModel userData;

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
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<UserBloc>().add(FetchUserById(userId: userData.userid!));
        },
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserByUIDLoaded) {
              userData = state.userData;

              for (var role in state.userData.roles!) {
                if (!currentRole.contains(roleMapping[role]!)) {
                  // currentRole.add(roleMapping[role]!);
                  currentRole.add(roleMapping[role]!);
                }
              }
            } else if (state is UserUpdated) {
              context
                  .read<UserBloc>()
                  .add(FetchUserById(userId: userData.userid!));
              Navigator.of(context).pop(); // Return updated roles
            }
          },
          builder: (context, state) {
            return BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserByUIDLoaded) {
                  return Center(
                    child: Column(
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
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: ButtonUpdateRBACAdmin(
        changeStatus: () async {
          // List<int>? updatedRoles =
          await showModalBottomSheet<List<int>>(
            backgroundColor: UIColor.solidWhite,
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) {
              List<int>? selectedRoles =
                  List.from(currentRole); // Copy initial state
              String? errorMessage;
              debugPrint("selected ${selectedRoles.toString()}");

              return BlocProvider.value(
                value: context.read<UserBloc>(),
                // create: (context) =>
                //     UserBloc(authBloc: context.read<AuthBloc>()),
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter modalSetState) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                          Wrap(
                            spacing: 8.0,
                            children: roleMapping.keys.map((roleName) {
                              return _roleButton(
                                roleName,
                                selectedRoles.contains(roleMapping[roleName]!)
                                    ? UIColor.getRoleColor(roleName)
                                    : Colors.grey.shade200,
                                selectedRoles.contains(roleMapping[roleName]!)
                                    ? Colors.white
                                    : Colors.black,
                                modalSetState,
                                selectedRoles,
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(null); // Return null
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(150, 50),
                                  backgroundColor: Colors.grey[200],
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: UIColor.typoBlack,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (selectedRoles.isEmpty) {
                                    modalSetState(() {
                                      errorMessage =
                                          "Select at least one role.";
                                    });
                                  } else {
                                    context.read<UserBloc>().add(
                                          UpdateUser(
                                            userData: UserDataModel(
                                              userid: userData.userid,
                                              changeRoles: selectedRoles,
                                            ),
                                          ),
                                        );
                                    // Navigator.of(context).pop(
                                    //     selectedRoles); // Return updated roles
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(150, 50),
                                  backgroundColor: Colors.blue,
                                ),
                                child: const Text(
                                  'Confirm',
                                  style: TextStyle(
                                    color: UIColor.solidWhite,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
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
        fixedSize: Size(100, 42),
        elevation: 0,
        foregroundColor: textColor,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12),
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
