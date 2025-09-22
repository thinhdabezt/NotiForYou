import 'package:flutter/material.dart';
import 'package:notiforyou/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Sign Out?",
    content: "Are you sure you want to sign out?",
    optionsBuilder: () => {"Cancel": false, "Yes": true},
  ).then((value) => value ?? false);
}
