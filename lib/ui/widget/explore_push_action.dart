import 'package:flutter/material.dart';

import '../../data/model/model.dart';

Future<void> explorePushAction(
  BuildContext context,
  String route,
  EventDataModel event,
  String currentRole,
) async {
  if (currentRole == 'Superadmin' || currentRole == 'Admin') {
    return showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Want to review ${event.category}: ${event.title}?'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        route,
                        arguments: {
                          'event_data': event,
                          'current_role': currentRole,
                          // 'token': token,
                        },
                      );
                    },
                    child: const Text('Confirm'),
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
