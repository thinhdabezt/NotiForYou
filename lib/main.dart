import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notiforyou/firebase_options.dart';
import 'package:notiforyou/view/login_view.dart';
import 'package:notiforyou/view/register_view.dart';
import 'package:notiforyou/view/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      routes: {
        "/login/": (context) => const LoginView(),
        "/register/": (context) => const RegisterView(),
        "/verify-email/": (context) => const VerifyEmailView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, asyncSnapshot) {
          switch (asyncSnapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if (user?.emailVerified ?? false) {
                  print("User is verified");
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const CircularProgressIndicator();
              }
              return const CircularProgressIndicator();
            default:
              return const CircularProgressIndicator();
          }
        },
      );
  }
}