import 'package:flutter/material.dart';
import 'package:notiforyou/constants/eight_bit_theme.dart';
import 'package:notiforyou/services/auth/auth_service.dart';
import 'package:notiforyou/view/widgets/pixel_widgets.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PixelAppBar(
        title: "VERIFY EMAIL",
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
                  "✉ VERIFICATION ✉",
                  style: EightBitTheme.titleStyle.copyWith(
                    fontSize: 28,
                    color: EightBitTheme.accentText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "CHECK YOUR EMAIL",
                  style: EightBitTheme.bodyStyle.copyWith(
                    color: EightBitTheme.secondaryText,
                  ),
                ),
                const SizedBox(height: 40),
                
                // Verification info container
                PixelContainer(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Main message
                      Text(
                        "MISSION BRIEFING:",
                        style: EightBitTheme.headingStyle.copyWith(
                          color: EightBitTheme.accentText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      
                      Text(
                        "We've sent you an email verification. Please check your inbox and click the link to verify your account.",
                        style: EightBitTheme.bodyStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      
                      // Divider
                      Container(
                        height: 2,
                        decoration: const BoxDecoration(
                          color: EightBitTheme.borderColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      Text(
                        "If you haven't received any verification email yet, press the button below.",
                        style: EightBitTheme.bodyStyle.copyWith(
                          color: EightBitTheme.secondaryText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      
                      // Send verification button
                      SizedBox(
                        width: double.infinity,
                        child: PixelButton(
                          text: "► SEND VERIFICATION ◄",
                          onPressed: () async {
                            await AuthService.firebase().sendEmailVerification();
                          },
                          height: 56,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Try again button
                      SizedBox(
                        width: double.infinity,
                        child: PixelButton(
                          text: "TRY AGAIN",
                          isSecondary: true,
                          onPressed: () async {
                            await AuthService.firebase().logout();
                            Navigator.of(context).pushNamedAndRemoveUntil("/register/", (route) => false);
                          },
                          height: 48,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // 8-bit decorative elements
                Text(
                  "░░░░░░░░░░░░░░░░░░░░",
                  style: EightBitTheme.bodyStyle.copyWith(
                    color: EightBitTheme.tertiaryBackground,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "★ GAME STATUS: PENDING ★",
                  style: EightBitTheme.bodyStyle.copyWith(
                    color: EightBitTheme.secondaryText,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "░░░░░░░░░░░░░░░░░░░░",
                  style: EightBitTheme.bodyStyle.copyWith(
                    color: EightBitTheme.tertiaryBackground,
                    fontSize: 16,
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