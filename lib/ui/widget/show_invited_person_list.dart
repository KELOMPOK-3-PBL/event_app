import 'package:event_proposal_app/data/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user_bloc/user_bloc.dart';

class InvitedDialog extends StatelessWidget {
  const InvitedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UsersLoaded) {
          final invitedPersons = state.listUser; // Data undangan
          final availablePersons =
              state.listUser; // Data orang lain yang bisa diundang

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Invited Person',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.grey[300],
                        child: Text(
                          '${invitedPersons.length}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search person...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: [
                        Text('Invited',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        ...invitedPersons.map((person) => _buildPersonTile(
                              context,
                              person,
                              isInvited: true,
                            )),
                        SizedBox(height: 8),
                        Text('Choose People',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        ...availablePersons.map((person) => _buildPersonTile(
                              context,
                              person,
                              isInvited: false,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Close'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Save action here
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (state is UserLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: Text('Something went wrong!'));
        }
      },
    );
  }

  Widget _buildPersonTile(BuildContext context, UserDataModel person,
      {required bool isInvited}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(person.avatar!),
      ),
      title: Text(person.username),
      subtitle: Text(
        person.roles![0],
        style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
      ),
      trailing: IconButton(
        icon: Icon(
          isInvited ? Icons.person_remove : Icons.person_add,
          color: isInvited ? Colors.red : Colors.blue,
        ),
        onPressed: () {
          if (isInvited) {
            // Remove from invited list
            // context.read<UserBloc>().add(RemoveInvitedPersonEvent(person));
          } else {
            // Add to invited list
            // context.read<UserBloc>().add(AddInvitedPersonEvent(person));
          }
        },
      ),
    );
  }
}

class Person {
  final String name;
  final String role;
  final String imageUrl;

  Person({required this.name, required this.role, required this.imageUrl});
}

// Ganti YourBloc dan YourState dengan nama Bloc dan State Anda.
