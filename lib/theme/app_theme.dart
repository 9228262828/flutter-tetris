import 'package:flutter/material.dart';

// Primary palette
const Color kPrimaryColor = Color(0xFF6C63FF);
const Color kPrimaryLight = Color(0xFF9C94FF);
const Color kPrimaryDark = Color(0xFF4A42CC);

// Accent palette
const Color kAccentColor = Color(0xFF00C9A7);
const Color kAccentDark = Color(0xFF009D82);

// Background layers
const Color kBackgroundColor = Color(0xFF1A1A2E);
const Color kSurfaceColor = Color(0xFF16213E);
const Color kCardColor = Color(0xFF0F3460);

// Game-specific colors
const Color kScreenBackground = Color(0xFF9EAD86);
const Color kScreenBorderShadow = Color(0xFF3D3680);
const Color kScreenBorderHighlight = Color(0xFF8B80FF);

// Text colors
const Color kTextPrimary = Colors.white;
const Color kTextSecondary = Color(0xFFB0AAFF);
const Color kTextMuted = Color(0xFF7A7A9D);

// Button danger
const Color kDangerColor = Color(0xFFFF5252);

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: kPrimaryColor,
      secondary: kAccentColor,
      surface: kSurfaceColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: kTextPrimary,
    ),
    scaffoldBackgroundColor: kBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: kSurfaceColor,
      foregroundColor: kTextPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: kTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      iconTheme: IconThemeData(color: kTextPrimary),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF2A2A4A),
      thickness: 1,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: kPrimaryColor,
      textColor: kTextPrimary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
        elevation: 4,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: kTextPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 28,
      ),
      headlineMedium: TextStyle(
        color: kTextPrimary,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      titleLarge: TextStyle(
        color: kTextPrimary,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      titleMedium: TextStyle(
        color: kTextSecondary,
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),
      bodyLarge: TextStyle(
        color: kTextPrimary,
        fontSize: 15,
        height: 1.6,
      ),
      bodyMedium: TextStyle(
        color: kTextSecondary,
        fontSize: 13,
        height: 1.5,
      ),
      labelSmall: TextStyle(
        color: kTextMuted,
        fontSize: 11,
        letterSpacing: 0.8,
      ),
    ),
    iconTheme: const IconThemeData(color: kTextPrimary),
  );
}
