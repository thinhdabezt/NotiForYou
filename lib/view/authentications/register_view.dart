import 'package:flutter/material.dart';
import 'package:notiforyou/constants/routes.dart';
import 'package:notiforyou/constants/eight_bit_theme.dart';
import 'package:notiforyou/services/auth/auth_exceptions.dart';
import 'package:notiforyou/services/auth/auth_service.dart';
import 'package:notiforyou/utilities/dialogs/error_dialog.dart';
import 'package:notiforyou/view/widgets/pixel_widgets.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: "REGISTER",
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
                  "♦ NEW PLAYER ♦",
                  style: EightBitTheme.titleStyle.copyWith(
                    fontSize: 28,
                    color: EightBitTheme.accentText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "CREATE YOUR ACCOUNT",
                  style: EightBitTheme.bodyStyle.copyWith(
                    color: EightBitTheme.secondaryText,
                  ),
                ),
                const SizedBox(height: 40),
                
                // Register form container
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
                        hintText: "new.player@example.com",
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
                      
                      // Register button
                      SizedBox(
                        width: double.infinity,
                        child: PixelButton(
                          text: "► REGISTER ◄",
                          onPressed: () async {
                            final email = _email.text;
                            final password = _password.text;
                            try {
                              await AuthService.firebase().register(email: email, password: password);
                              await AuthService.firebase().sendEmailVerification();
                              Navigator.of(context).pushNamed(verifyEmailRoute);
                            } on EmailAlreadyInUseAuthException {
                              await showErrorDialog(context, 'Email is already in use.');
                            } on InvalidEmailAuthException {
                              await showErrorDialog(context, 'Invalid email.');
                            } on WeakPasswordAuthException {
                              await showErrorDialog(context, 'Weak password.');
                            } on GenericAuthException {
                              await showErrorDialog(context, 'Failed to register.');
                            }
                          },
                          height: 56,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Login link
                Text(
                  "ALREADY REGISTERED?",
                  style: EightBitTheme.bodyStyle.copyWith(
                    color: EightBitTheme.secondaryText,
                  ),
                ),
                const SizedBox(height: 12),
                PixelButton(
                  text: "LOGIN HERE",
                  isSecondary: true,
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  },
                  width: double.infinity,
                  height: 48,
                ),
                
                const SizedBox(height: 40),
                
                // 8-bit decorative elements
                Text(
                  "◆◇◆◇◆◇◆◇◆◇◆◇◆◇◆◇",
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