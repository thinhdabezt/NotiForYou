import 'package:flutter/material.dart';

class EightBitTheme {
  // 8-bit inspired color palette
  static const Color primaryBackground = Color(0xFF0D1B2A); // Dark navy blue
  static const Color secondaryBackground = Color(0xFF1B263B); // Slightly lighter navy
  static const Color tertiaryBackground = Color(0xFF415A77); // Medium blue-gray
  
  static const Color primaryText = Color(0xFF00FF00); // Bright green (classic terminal)
  static const Color secondaryText = Color(0xFF00CCCC); // Cyan
  static const Color accentText = Color(0xFFFFFF00); // Bright yellow
  static const Color errorText = Color(0xFFFF0066); // Hot pink/red
  
  static const Color primaryButton = Color(0xFF00AA00); // Dark green
  static const Color primaryButtonHover = Color(0xFF00FF00); // Bright green
  static const Color secondaryButton = Color(0xFF0088AA); // Dark cyan
  static const Color secondaryButtonHover = Color(0xFF00CCCC); // Bright cyan
  
  static const Color borderColor = Color(0xFF00FF00); // Green border
  static const Color focusedBorderColor = Color(0xFFFFFF00); // Yellow when focused
  static const Color errorBorderColor = Color(0xFFFF0066); // Pink/red for errors
  
  static const Color cardBackground = Color(0xFF1B263B);
  static const Color inputBackground = Color(0xFF0D1B2A);
  
  // 8-bit inspired shadows and effects
  static const Color shadowColor = Color(0xFF000000);
  static const double pixelBorderWidth = 3.0;
  static const double pixelRadius = 0.0; // Sharp corners for pixel effect
  
  // Typography - using a monospace font to simulate 8-bit text
  static const String fontFamily = 'Courier'; // Monospace font
  
  static const TextStyle titleStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: primaryText,
    letterSpacing: 2.0,
  );
  
  static const TextStyle headingStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: secondaryText,
    letterSpacing: 1.5,
  );
  
  static const TextStyle bodyStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.0,
    color: primaryText,
    letterSpacing: 1.0,
  );
  
  static const TextStyle buttonStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: primaryBackground,
    letterSpacing: 1.5,
  );
  
  static const TextStyle hintStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.0,
    color: Color(0xFF666666),
    letterSpacing: 1.0,
  );
  
  // Button decorations
  static BoxDecoration pixelButtonDecoration({
    Color backgroundColor = primaryButton,
    Color borderColor = borderColor,
    bool isPressed = false,
  }) {
    return BoxDecoration(
      color: backgroundColor,
      border: Border.all(
        color: borderColor,
        width: pixelBorderWidth,
      ),
      borderRadius: BorderRadius.circular(pixelRadius),
      boxShadow: isPressed 
        ? [] 
        : [
            const BoxShadow(
              color: shadowColor,
              offset: Offset(4, 4),
              blurRadius: 0,
            ),
          ],
    );
  }
  
  // Input field decoration
  static InputDecoration pixelInputDecoration({
    String? hintText,
    Color borderColor = borderColor,
    Color focusedBorderColor = focusedBorderColor,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: hintStyle,
      filled: true,
      fillColor: inputBackground,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(pixelRadius),
        borderSide: BorderSide(
          color: borderColor,
          width: pixelBorderWidth,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(pixelRadius),
        borderSide: BorderSide(
          color: focusedBorderColor,
          width: pixelBorderWidth,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(pixelRadius),
        borderSide: BorderSide(
          color: errorBorderColor,
          width: pixelBorderWidth,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(pixelRadius),
        borderSide: BorderSide(
          color: errorBorderColor,
          width: pixelBorderWidth,
        ),
      ),
    );
  }
  
  // Card decoration
  static BoxDecoration pixelCardDecoration({
    Color backgroundColor = cardBackground,
    Color borderColor = borderColor,
  }) {
    return BoxDecoration(
      color: backgroundColor,
      border: Border.all(
        color: borderColor,
        width: pixelBorderWidth,
      ),
      borderRadius: BorderRadius.circular(pixelRadius),
      boxShadow: const [
        BoxShadow(
          color: shadowColor,
          offset: Offset(4, 4),
          blurRadius: 0,
        ),
      ],
    );
  }
  
  // App bar decoration
  static BoxDecoration pixelAppBarDecoration() {
    return const BoxDecoration(
      color: secondaryBackground,
      border: Border(
        bottom: BorderSide(
          color: borderColor,
          width: pixelBorderWidth,
        ),
      ),
    );
  }
  
  // Material theme data for the app
  static ThemeData get themeData {
    return ThemeData(
      fontFamily: fontFamily,
      scaffoldBackgroundColor: primaryBackground,
      colorScheme: const ColorScheme.dark(
        primary: primaryButton,
        secondary: secondaryButton,
        surface: cardBackground,
        background: primaryBackground,
        error: errorText,
        onPrimary: primaryBackground,
        onSecondary: primaryBackground,
        onSurface: primaryText,
        onBackground: primaryText,
        onError: primaryBackground,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: secondaryBackground,
        foregroundColor: primaryText,
        elevation: 0,
        titleTextStyle: headingStyle,
        iconTheme: IconThemeData(
          color: primaryText,
          size: 24,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: titleStyle,
        displayMedium: headingStyle,
        bodyLarge: bodyStyle,
        bodyMedium: bodyStyle,
        titleMedium: headingStyle,
        labelLarge: buttonStyle,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryButton,
          foregroundColor: primaryBackground,
          textStyle: buttonStyle,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(pixelRadius),
            side: const BorderSide(
              color: borderColor,
              width: pixelBorderWidth,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: secondaryText,
          textStyle: bodyStyle,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputBackground,
        hintStyle: hintStyle,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(pixelRadius),
          borderSide: const BorderSide(
            color: borderColor,
            width: pixelBorderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(pixelRadius),
          borderSide: const BorderSide(
            color: focusedBorderColor,
            width: pixelBorderWidth,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(pixelRadius),
          side: const BorderSide(
            color: borderColor,
            width: pixelBorderWidth,
          ),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        textColor: primaryText,
        iconColor: secondaryText,
      ),
      iconTheme: const IconThemeData(
        color: primaryText,
        size: 24,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryButton,
        linearTrackColor: tertiaryBackground,
        circularTrackColor: tertiaryBackground,
      ),
    );
  }
}