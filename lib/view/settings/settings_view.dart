import 'package:flutter/material.dart';
import 'package:notiforyou/constants/eight_bit_themes.dart';
import 'package:notiforyou/services/audio/retro_sound_service.dart';
import 'package:notiforyou/services/theme/theme_manager.dart';
import 'package:notiforyou/services/easter_eggs/easter_egg_service.dart';
import 'package:notiforyou/view/widgets/pixel_widgets.dart';
import 'package:notiforyou/view/widgets/pixel_icons.dart';
import 'package:notiforyou/view/widgets/animations.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  int _secretTapCount = 0;

  void _handleSecretTap() {
    _secretTapCount++;
    if (_secretTapCount >= 7) {
      _secretTapCount = 0;
      retroSounds.playEasterEgg();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const SecretMinigame(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PixelAppBar(
        title: "⚙ SETTINGS ⚙",
        leading: PixelIconButton(
          icon: Icons.arrow_back,
          onPressed: () {
            retroSounds.playNavigation();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              themeManager.currentTheme.primaryBackground,
              themeManager.currentTheme.secondaryBackground,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Theme Settings
            PixelContainer(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      PixelIcons.theme(
                        color: themeManager.currentTheme.accentText,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "COLOR SCHEMES",
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: themeManager.currentTheme.accentText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Current theme display
                  PixelContainer(
                    backgroundColor: themeManager.currentTheme.inputBackground,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Text(
                          themeManager.currentTheme.themeEmoji,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Current: ${themeManager.currentTheme.themeName}",
                            style: TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 16,
                              color: themeManager.currentTheme.primaryText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Theme selection grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: EightBitThemes.allThemes.length,
                    itemBuilder: (context, index) {
                      final themeType = EightBitThemes.allThemes[index];
                      final theme = EightBitThemes.getTheme(themeType);
                      final isSelected = themeManager.currentThemeType == themeType;

                      return GestureDetector(
                        onTap: () {
                          themeManager.setTheme(themeType);
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.cardBackground,
                            border: Border.all(
                              color: isSelected 
                                  ? theme.focusedBorderColor 
                                  : theme.borderColor,
                              width: isSelected ? 3 : 2,
                            ),
                            boxShadow: isSelected ? [
                              BoxShadow(
                                color: theme.focusedBorderColor.withValues(alpha: 0.3),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ] : null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Text(
                                  theme.themeEmoji,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    theme.themeName,
                                    style: TextStyle(
                                      fontFamily: 'Courier',
                                      fontSize: 12,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      color: theme.primaryText,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Sound Settings
            PixelContainer(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      PixelIcons.sound(
                        color: themeManager.currentTheme.accentText,
                        size: 24,
                        enabled: retroSounds.soundEnabled,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "AUDIO SETTINGS",
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: themeManager.currentTheme.accentText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Retro Sound Effects",
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 16,
                            color: themeManager.currentTheme.primaryText,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          retroSounds.toggleSound();
                          retroSounds.playButtonPress();
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: retroSounds.soundEnabled 
                                ? themeManager.currentTheme.primaryButton
                                : themeManager.currentTheme.tertiaryBackground,
                            border: Border.all(
                              color: themeManager.currentTheme.borderColor,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            retroSounds.soundEnabled ? "ON" : "OFF",
                            style: TextStyle(
                              fontFamily: 'Courier',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: retroSounds.soundEnabled 
                                  ? themeManager.currentTheme.primaryBackground
                                  : themeManager.currentTheme.primaryText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Sound test buttons
                  Text(
                    "Test Sounds:",
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 14,
                      color: themeManager.currentTheme.secondaryText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildSoundTestButton("Beep", retroSounds.playButtonPress),
                      _buildSoundTestButton("Success", retroSounds.playSuccess),
                      _buildSoundTestButton("Error", retroSounds.playError),
                      _buildSoundTestButton("Save", retroSounds.playSave),
                    ],
                  ),
                ],
              ),
            ),

            // Easter Egg Section (hidden trigger)
            GestureDetector(
              onTap: _handleSecretTap,
              child: PixelContainer(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        PixelIcons.settings(
                          color: themeManager.currentTheme.accentText,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "ABOUT",
                          style: TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: themeManager.currentTheme.accentText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    TypingAnimation(
                      text: "NotiforyouY v1.0.0\n\n8-Bit retro theme enabled!\nComplete with sound effects,\nanimations, and hidden secrets...\n\nTap here 7 times to unlock\nsomething special! 🎮",
                      speed: const Duration(milliseconds: 30),
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 14,
                        color: themeManager.currentTheme.primaryText,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Matrix rain background (decorative)
            SizedBox(
              height: 100,
              child: PixelContainer(
                padding: const EdgeInsets.all(4),
                child: ClipRect(
                  child: MatrixRainAnimation(
                    height: 92,
                    width: MediaQuery.of(context).size.width - 40,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSoundTestButton(String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: themeManager.currentTheme.secondaryButton,
          border: Border.all(
            color: themeManager.currentTheme.borderColor,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Courier',
            fontSize: 12,
            color: themeManager.currentTheme.primaryBackground,
          ),
        ),
      ),
    );
  }
}