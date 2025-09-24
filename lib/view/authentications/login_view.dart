import 'package:flutter/material.dart';
import 'package:notiforyou/constants/routes.dart';
import 'package:notiforyou/constants/eight_bit_theme.dart';
import 'package:notiforyou/services/auth/auth_exceptions.dart';
import 'package:notiforyou/services/auth/auth_service.dart';
import 'package:notiforyou/utilities/dialogs/error_dialog.dart';
import 'package:notiforyou/view/widgets/pixel_widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PixelAppBar(
        title: "LOGIN",
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              EightBitTheme.primaryBackground,
              EightBitTheme.secondaryBackground,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                // Title with 8-bit style
                Text(
                  "▄▄▄ WELCOME ▄▄▄",
                  style: EightBitTheme.titleStyle.copyWith(
                    fontSize: 28,
                    color: EightBitTheme.accentText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "ENTER YOUR CREDENTIALS",
                  style: EightBitTheme.bodyStyle.copyWith(
                    color: EightBitTheme.secondaryText,
                  ),
                ),
                const SizedBox(height: 40),
                
                // Login form container
                PixelContainer(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Email field
                      Text(
                        "EMAIL:",
                        style: EightBitTheme.bodyStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      PixelTextField(
                        controller: _email,
                        hintText: "player@example.com",
                        keyboardType: TextInputType.emailAddress,
                        enableSuggestions: false,
                        autocorrect: false,
                      ),
                      const SizedBox(height: 20),
                      
                      // Password field
                      Text(
                        "PASSWORD:",
                        style: EightBitTheme.bodyStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      PixelTextField(
                        controller: _password,
                        hintText: "••••••••",
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                      ),
                      const SizedBox(height: 32),
                      
                      // Login button
                      SizedBox(
                        width: double.infinity,
                        child: PixelButton(
                          text: "► LOGIN ◄",
                          onPressed: () async {
                            final email = _email.text;
                            final password = _password.text;
                            try {
                              await AuthService.firebase().login(
                                email: email,
                                password: password,
                              );
                              final user = AuthService.firebase().currentUser;
                              if (user?.isEmailVerified ?? false) {
                                Navigator.of(
                                  context,
                                ).pushNamedAndRemoveUntil(notesRoute, (route) => false);
                              } else {
                                Navigator.of(
                                  context,
                                ).pushNamedAndRemoveUntil(verifyEmailRoute, (route) => false);
                              }
                            } on UserNotFoundAuthException {
                              await showErrorDialog(context, 'No user found for that email.');
                            } on InvalidCredentialAuthException {
                              await showErrorDialog(
                                context,
                                'Wrong email or password provided for that user.',
                              );
                            } on GenericAuthException {
                              await showErrorDialog(context, 'Authentication error');
                            }
                          },
                          height: 56,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Register link
                Text(
                  "NOT REGISTERED YET?",
                  style: EightBitTheme.bodyStyle.copyWith(
                    color: EightBitTheme.secondaryText,
                  ),
                ),
                const SizedBox(height: 12),
                PixelButton(
                  text: "CREATE ACCOUNT",
                  isSecondary: true,
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil(registerRoute, (route) => false);
                  },
                  width: double.infinity,
                  height: 48,
                ),
                
                const SizedBox(height: 40),
                
                // 8-bit decorative elements
                Text(
                  "▲▼▲▼▲▼▲▼▲▼▲▼▲▼▲▼",
                  style: EightBitTheme.bodyStyle.copyWith(
                    color: EightBitTheme.tertiaryBackground,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}