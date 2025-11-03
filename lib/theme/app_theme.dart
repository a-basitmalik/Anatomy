import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AppTheme {
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.transparent,
    primaryColor: AppConstants.primaryBlue,
    colorScheme: ColorScheme.dark(
      primary: AppConstants.primaryBlue,
      secondary: AppConstants.accentGreen,
      surface: AppConstants.cardDark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppConstants.cardDark.withOpacity(0.6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppConstants.primaryBlue, width: 2),
      ),
      hintStyle: TextStyle(color: Colors.white54),
      labelStyle: TextStyle(color: AppConstants.primaryBlue),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.2,
      ),
      headlineSmall: TextStyle(
        fontSize: 16,
        color: Colors.white70,
        letterSpacing: 1.1,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    ),
  );
}