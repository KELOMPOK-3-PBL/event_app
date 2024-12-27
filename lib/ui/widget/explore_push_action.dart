import 'package:event_proposal_app/bloc/bloc.dart';
import 'package:event_proposal_app/ui/widget/show_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/model.dart';

Future<void> explorePushAction(
  BuildContext context,
  String route,
  EventDataModel event,
  String currentRole,
) async {
  // Menampilkan dialog konfirmasi untuk mereview jika role adalah Admin/Superadmin
  if ((currentRole == 'Superadmin' || currentRole == 'Admin') &&
      event.status == 'Proposed') {
    return showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Want to review ${event.category}: ${event.title}?'),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    child: const Text('Cancel'),
                  ),
                  BlocProvider(
                    create: (context) =>
                        EventBloc(authBloc: context.read<AuthBloc>()),
                    child: BlocConsumer<EventBloc, EventState>(
                      listener: (context, state) {
                        if (state is EventUpdated) {
                          debugPrint('EVENT UPDATED TO REVIEW');
                          Navigator.pushReplacementNamed(
                            dialogContext,
                            route,
                            arguments: {
                              'event_data': event,
                              'current_role': currentRole,
                              // 'token': token,
                            },
                          );
                        } else if (state is EventError) {
                          showCustomSnackBar(context, state.message);
                        }
                      },
                      builder: (context, state) {
                        return TextButton(
                          onPressed: () {
                            try {
                              event = event.copyWith(
                                  statusID: 3, status: 'Review Admin');
                              context
                                  .read<EventBloc>()
                                  .add(EventUpdateData(eventData: event));
                            } catch (_) {
                              showCustomSnackBar(
                                  context, 'Failed to review event');
                            }
                          },
                          child: const Text('Confirm'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  } else {
    Navigator.pushNamed(
      context,
      route,
      arguments: {'event_data': event, 'current_role': currentRole},
    );
  }
}
