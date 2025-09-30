import 'package:flutter/material.dart';
import 'package:notiforyou/constants/eight_bit_themes.dart';
import 'package:notiforyou/services/audio/retro_sound_service.dart';

class EightBitThemeManager extends ChangeNotifier {
  static final EightBitThemeManager _instance = EightBitThemeManager._internal();
  factory EightBitThemeManager() => _instance;
  EightBitThemeManager._internal();

  EightBitThemeType _currentTheme = EightBitThemeType.classic;
  
  EightBitThemeType get currentThemeType => _currentTheme;
  EightBitColorScheme get currentTheme => EightBitThemes.getTheme(_currentTheme);

  void setTheme(EightBitThemeType theme) {
    if (_currentTheme != theme) {
      _currentTheme = theme;
      retroSounds.playNavigation();
      notifyListeners();
    }
  }

  void nextTheme() {
    final themes = EightBitThemes.allThemes;
    final currentIndex = themes.indexOf(_currentTheme);
    final nextIndex = (currentIndex + 1) % themes.length;
    setTheme(themes[nextIndex]);
  }

  void previousTheme() {
    final themes = EightBitThemes.allThemes;
    final currentIndex = themes.indexOf(_currentTheme);
    final previousIndex = (currentIndex - 1 + themes.length) % themes.length;
    setTheme(themes[previousIndex]);
  }

  // Updated theme data that uses current theme
  ThemeData get themeData {
    final scheme = currentTheme;
    const fontFamily = 'Courier';
    
    return ThemeData(
      fontFamily: fontFamily,
      scaffoldBackgroundColor: scheme.primaryBackground,
      colorScheme: ColorScheme.dark(
        primary: scheme.primaryButton,
        secondary: scheme.secondaryButton,
        surface: scheme.cardBackground,
        error: scheme.errorText,
        onPrimary: scheme.primaryBackground,
        onSecondary: scheme.primaryBackground,
        onSurface: scheme.primaryText,
        onError: scheme.primaryBackground,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.secondaryBackground,
        foregroundColor: scheme.primaryText,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: scheme.secondaryText,
          letterSpacing: 1.5,
        ),
        iconTheme: IconThemeData(
          color: scheme.primaryText,
          size: 24,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: scheme.primaryText,
          letterSpacing: 2.0,
        ),
        displayMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: scheme.secondaryText,
          letterSpacing: 1.5,
        ),
        bodyLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16.0,
          color: scheme.primaryText,
          letterSpacing: 1.0,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16.0,
          color: scheme.primaryText,
          letterSpacing: 1.0,
        ),
        titleMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: scheme.secondaryText,
          letterSpacing: 1.5,
        ),
        labelLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: scheme.primaryBackground,
          letterSpacing: 1.5,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primaryButton,
          foregroundColor: scheme.primaryBackground,
          textStyle: TextStyle(
            fontFamily: fontFamily,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: scheme.primaryBackground,
            letterSpacing: 1.5,
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide(
              color: scheme.borderColor,
              width: 3.0,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.secondaryText,
          textStyle: TextStyle(
            fontFamily: fontFamily,
            fontSize: 16.0,
            color: scheme.primaryText,
            letterSpacing: 1.0,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.inputBackground,
        hintStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14.0,
          color: const Color(0xFF666666),
          letterSpacing: 1.0,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(
            color: scheme.borderColor,
            width: 3.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(
            color: scheme.focusedBorderColor,
            width: 3.0,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(
            color: scheme.borderColor,
            width: 3.0,
          ),
        ),
      ),
      listTileTheme: ListTileThemeData(
        textColor: scheme.primaryText,
        iconColor: scheme.secondaryText,
      ),
      iconTheme: IconThemeData(
        color: scheme.primaryText,
        size: 24,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primaryButton,
        linearTrackColor: scheme.tertiaryBackground,
        circularTrackColor: scheme.tertiaryBackground,
      ),
    );
  }
}

// Convenient global access
final themeManager = EightBitThemeManager();