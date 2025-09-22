import 'package:flutter/material.dart';
import 'package:notiforyou/constants/routes.dart';
import 'package:notiforyou/enums/menu_action.dart';
import 'package:notiforyou/services/auth/auth_service.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Note(s)"),
        backgroundColor: Colors.blueAccent,
        actions: [
          PopupMenuButton(
            onSelected: (value) async {
              switch(value){
                case MenuAction.logout:
                  final signOut = await showLogOutDialog(context);
                  if(signOut){
                    await AuthService.firebase().logout();
                    Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text("Sign Out"),
                ),
              ];
            },
          ),
        ],
      ),
      body: const Center(child: Text("Hello World")),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context){
  return showDialog<bool>(
    context: context, 
    builder: (context){
      return AlertDialog(
        title: const Text("Sign Out"),
        content: const Text("Are you sure you want to sign out?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            }, 
            child: const Text("Cancel")
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            }, 
            child: const Text("Sign Out")
          ),
        ],
      );
    }
  ).then((value) => value ?? false);
}