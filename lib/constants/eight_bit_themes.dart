import 'package:flutter/material.dart';

enum EightBitThemeType {
  classic, // Green terminal (default)
  amber,   // Amber monochrome
  blue,    // Blue cyberpunk
  red,     // Red alert
  purple,  // Purple mystical
}

class EightBitColorScheme {
  final Color primaryBackground;
  final Color secondaryBackground;
  final Color tertiaryBackground;
  final Color primaryText;
  final Color secondaryText;
  final Color accentText;
  final Color errorText;
  final Color primaryButton;
  final Color primaryButtonHover;
  final Color secondaryButton;
  final Color secondaryButtonHover;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color cardBackground;
  final Color inputBackground;
  final String themeName;
  final String themeEmoji;

  const EightBitColorScheme({
    required this.primaryBackground,
    required this.secondaryBackground,
    required this.tertiaryBackground,
    required this.primaryText,
    required this.secondaryText,
    required this.accentText,
    required this.errorText,
    required this.primaryButton,
    required this.primaryButtonHover,
    required this.secondaryButton,
    required this.secondaryButtonHover,
    required this.borderColor,
    required this.focusedBorderColor,
    required this.errorBorderColor,
    required this.cardBackground,
    required this.inputBackground,
    required this.themeName,
    required this.themeEmoji,
  });
}

class EightBitThemes {
  static const EightBitColorScheme classic = EightBitColorScheme(
    primaryBackground: Color(0xFF0D1B2A),
    secondaryBackground: Color(0xFF1B263B),
    tertiaryBackground: Color(0xFF415A77),
    primaryText: Color(0xFF00FF00),
    secondaryText: Color(0xFF00CCCC),
    accentText: Color(0xFFFFFF00),
    errorText: Color(0xFFFF0066),
    primaryButton: Color(0xFF00AA00),
    primaryButtonHover: Color(0xFF00FF00),
    secondaryButton: Color(0xFF0088AA),
    secondaryButtonHover: Color(0xFF00CCCC),
    borderColor: Color(0xFF00FF00),
    focusedBorderColor: Color(0xFFFFFF00),
    errorBorderColor: Color(0xFFFF0066),
    cardBackground: Color(0xFF1B263B),
    inputBackground: Color(0xFF0D1B2A),
    themeName: "Classic Terminal",
    themeEmoji: "🟢",
  );

  static const EightBitColorScheme amber = EightBitColorScheme(
    primaryBackground: Color(0xFF1A0E00),
    secondaryBackground: Color(0xFF2D1B00),
    tertiaryBackground: Color(0xFF4A2D00),
    primaryText: Color(0xFFFFB000),
    secondaryText: Color(0xFFFF8C00),
    accentText: Color(0xFFFFE135),
    errorText: Color(0xFFFF4444),
    primaryButton: Color(0xFFCC8800),
    primaryButtonHover: Color(0xFFFFB000),
    secondaryButton: Color(0xFF996600),
    secondaryButtonHover: Color(0xFFCC8800),
    borderColor: Color(0xFFFFB000),
    focusedBorderColor: Color(0xFFFFE135),
    errorBorderColor: Color(0xFFFF4444),
    cardBackground: Color(0xFF2D1B00),
    inputBackground: Color(0xFF1A0E00),
    themeName: "Amber Retro",
    themeEmoji: "🟡",
  );

  static const EightBitColorScheme blue = EightBitColorScheme(
    primaryBackground: Color(0xFF0A0A1F),
    secondaryBackground: Color(0xFF1A1A3A),
    tertiaryBackground: Color(0xFF2A2A5A),
    primaryText: Color(0xFF00DDFF),
    secondaryText: Color(0xFF0099CC),
    accentText: Color(0xFF66FFFF),
    errorText: Color(0xFFFF6B9D),
    primaryButton: Color(0xFF0088CC),
    primaryButtonHover: Color(0xFF00DDFF),
    secondaryButton: Color(0xFF006699),
    secondaryButtonHover: Color(0xFF0088CC),
    borderColor: Color(0xFF00DDFF),
    focusedBorderColor: Color(0xFF66FFFF),
    errorBorderColor: Color(0xFFFF6B9D),
    cardBackground: Color(0xFF1A1A3A),
    inputBackground: Color(0xFF0A0A1F),
    themeName: "Cyber Blue",
    themeEmoji: "🔵",
  );

  static const EightBitColorScheme red = EightBitColorScheme(
    primaryBackground: Color(0xFF1F0505),
    secondaryBackground: Color(0xFF3A0A0A),
    tertiaryBackground: Color(0xFF5A1515),
    primaryText: Color(0xFFFF4444),
    secondaryText: Color(0xFFCC2222),
    accentText: Color(0xFFFF8888),
    errorText: Color(0xFFFFAAAA),
    primaryButton: Color(0xFFCC1111),
    primaryButtonHover: Color(0xFFFF4444),
    secondaryButton: Color(0xFF990000),
    secondaryButtonHover: Color(0xFFCC1111),
    borderColor: Color(0xFFFF4444),
    focusedBorderColor: Color(0xFFFF8888),
    errorBorderColor: Color(0xFFFFAAAA),
    cardBackground: Color(0xFF3A0A0A),
    inputBackground: Color(0xFF1F0505),
    themeName: "Red Alert",
    themeEmoji: "🔴",
  );

  static const EightBitColorScheme purple = EightBitColorScheme(
    primaryBackground: Color(0xFF1A0A1F),
    secondaryBackground: Color(0xFF2D1A3A),
    tertiaryBackground: Color(0xFF4A2A5A),
    primaryText: Color(0xFFDD88FF),
    secondaryText: Color(0xFFAA55CC),
    accentText: Color(0xFFFFAAFF),
    errorText: Color(0xFFFF6666),
    primaryButton: Color(0xFF8844AA),
    primaryButtonHover: Color(0xFFDD88FF),
    secondaryButton: Color(0xFF663388),
    secondaryButtonHover: Color(0xFF8844AA),
    borderColor: Color(0xFFDD88FF),
    focusedBorderColor: Color(0xFFFFAAFF),
    errorBorderColor: Color(0xFFFF6666),
    cardBackground: Color(0xFF2D1A3A),
    inputBackground: Color(0xFF1A0A1F),
    themeName: "Mystic Purple",
    themeEmoji: "🟣",
  );

  static const Map<EightBitThemeType, EightBitColorScheme> themes = {
    EightBitThemeType.classic: classic,
    EightBitThemeType.amber: amber,
    EightBitThemeType.blue: blue,
    EightBitThemeType.red: red,
    EightBitThemeType.purple: purple,
  };

  static EightBitColorScheme getTheme(EightBitThemeType type) {
    return themes[type] ?? classic;
  }

  static List<EightBitThemeType> get allThemes => EightBitThemeType.values;
}