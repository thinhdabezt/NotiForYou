import 'package:flutter/material.dart';
import 'package:notiforyou/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
      ),
      body: Column(
        children: [
          const Text("We've sent you an email verification. Please check your inbox and open it to verify your account."),
          const Text("If you haven't received any verification email yet, please press the button below."),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () async {
                    await AuthService.firebase().sendEmailVerification();
                  },
                  child: const Text("Send Verification Email"),
                ),
                TextButton(
                  onPressed: () async {
                    await AuthService.firebase().logout();
                    Navigator.of(context).pushNamedAndRemoveUntil("/register/", (route) => false);
                  },
                  child: const Text("Try Again"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}