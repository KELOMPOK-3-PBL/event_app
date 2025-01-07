import 'package:event_proposal_app/data/model/model.dart';
import 'package:event_proposal_app/ui/theme/ui_colors.dart';
// import 'package:event_proposal_app/ui/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';

class InvitedDialog extends StatefulWidget {
  const InvitedDialog({super.key, required this.eventData});
  final EventDataModel eventData;

  @override
  State<InvitedDialog> createState() => _InvitedDialogState();
}

class _InvitedDialogState extends State<InvitedDialog> {
  final ScrollController _scrollController = ScrollController();
  List<int> inviteUsersId = [];
  List<UserDataModel> invitedPersons = [];
  List<UserDataModel> availablePersons = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Cek apakah invitedPersons null
    final invitedPersonsList = widget.eventData.invitedPersons ?? [];

    debugPrint(invitedPersonsList.toString());

    // Menambahkan invited user ke dalam list
    for (var person in invitedPersonsList) {
      inviteUsersId.add(int.parse(person.userId!));
      invitedPersons.add(
        UserDataModel(
          username: person.username,
          userid: person.userId,
          avatarLink: person.avatar,
        ),
      );
      // } else {
      //   debugPrint('Invalid person data: $person');
      // }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onScroll() {
    if (_isBottom &&
        !(context.read<UserBloc>().state as UsersLoaded).hasReachedMax) {
      //! mengatasi perubahan request ketika di scroll
      // mengambil request yang sudah diubah current statenya
      // requestFilteredEvent =
      //     (context.read<EventBloc>().state as EventLoaded).requestEvent;
      // requestEvent.copyWith();
      context.read<UserBloc>().add(
            FetchUser(
                // searchUser: searchUser,
                // sort: sort,
                // order: order,
                // role: role,
                ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UsersLoaded) {
          availablePersons = state.listUser;
          for (var person in invitedPersons) {
            availablePersons.contains(person);
          }

          debugPrint('Invited Persons: $invitedPersons');
          debugPrint('Invited Persons UserId: $inviteUsersId');
          return Dialog(
            backgroundColor: UIColor.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height - 200,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Invite Person',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: UIColor.primary,
                        child: Text(
                          '${invitedPersons.length}',
                          style: const TextStyle(
                              fontSize: 12, color: UIColor.solidWhite),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 16),
                  // SearchWidget(
                  //   haveFilter: false,
                  //   label: 'Search person',
                  //   onSubmittedKeyboard: (searchQuery) {
                  //     // Implementasikan pencarian
                  //   },
                  // ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      controller: _scrollController,
                      shrinkWrap: true,
                      children: [
                        const Text('Invited',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        if (invitedPersons.isNotEmpty)
                          ...invitedPersons.map((person) => _buildPersonTile(
                                context,
                                person,
                                isInvited: true,
                              ))
                        else
                          const Text('No invited persons found.'),
                        const SizedBox(height: 8),
                        const Text('Choose People',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        if (availablePersons.isNotEmpty)
                          ...availablePersons.map((person) => _buildPersonTile(
                                context,
                                person,
                                isInvited: false,
                              ))
                        else
                          const Text('No available persons to invite.'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Close',
                            style: TextStyle(color: UIColor.typoBlack),
                          )),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(UIColor.primary)),
                          onPressed: () {
                            context.read<EventBloc>().add(
                                  EventUpdateData(
                                    eventData: widget.eventData.copyWith(
                                        inviteUser: inviteUsersId,
                                        isInvitePerson: true),
                                  ),
                                );
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(color: UIColor.solidWhite),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('Something went wrong!'));
        }
      },
    );
  }

  Widget _buildPersonTile(BuildContext context, UserDataModel person,
      {required bool isInvited}) {
    // Pastikan atribut valid
    final avatarUrl = person.avatarLink ??
        'https://img.freepik.com/free-vector/illustration-businessman_53876-5856.jpg?t=st=1729955954~exp=1729959554~hmac=21f4e9f848ed4521b47e6041fcd202d019651577ec676e23bba8e7fe93adce16&w=826';
    final username = person.username;
    // final role =
    //     person.roles?.isNotEmpty == true ? person.roles![0] : 'Unknown';

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(avatarUrl),
      ),
      title: Text(username!),
      // subtitle: Text(
      //   role,
      //   style:
      //       const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
      // ),
      trailing: IconButton(
        icon: Icon(
          isInvited ? Icons.person_remove : Icons.person_add,
          color: isInvited ? Colors.red : Colors.blue,
        ),
        onPressed: () {
          if (isInvited) {
            setState(() {
              // Hapus dari daftar undangan
              inviteUsersId.remove(int.parse(person.userid!));
              invitedPersons.remove(person);
              availablePersons.insert(0, person);
            });
          } else {
            if (!inviteUsersId.contains(int.parse(person.userid!))) {
              setState(() {
                // Tambahkan ke daftar undangan
                inviteUsersId.add(int.parse(person.userid!));
                invitedPersons.add(person);
                availablePersons.remove(person);
              });
            }
          }
        },
      ),
    );
  }
}
