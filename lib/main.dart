import 'package:flutter/material.dart';
import 'package:notiforyou/constants/routes.dart';
import 'package:notiforyou/services/theme/theme_manager.dart';
import 'package:notiforyou/services/auth/auth_service.dart';
import 'package:notiforyou/view/authentications/login_view.dart';
import 'package:notiforyou/view/notes/create_update_note_view.dart';
import 'package:notiforyou/view/notes/notes_view.dart';
import 'package:notiforyou/view/authentications/register_view.dart';
import 'package:notiforyou/view/authentications/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NotiforyouApp());
}

class NotiforyouApp extends StatelessWidget {
  const NotiforyouApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeManager,
      builder: (context, child) {
        return MaterialApp(
          title: 'NotiforyouY - 8-Bit Style',
          theme: themeManager.themeData,
          home: const HomePage(),
          routes: {
            loginRoute: (context) => const LoginView(),
            registerRoute: (context) => const RegisterView(),
            verifyEmailRoute: (context) => const VerifyEmailView(),
            notesRoute: (context) => const NotesView(),
            createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
          },
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, asyncSnapshot) {
        switch (asyncSnapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const NotesView();
        }
      },
    );
  }
}

