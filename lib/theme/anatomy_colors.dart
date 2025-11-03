import 'package:flutter/material.dart';

class AnatomyColors {
  // DeepSeek Color Scheme
  static const Color deepPurple = Color(0xFF1B103E);
  static const Color darkNavy = Color(0xFF0A0E2A);
  static const Color lightPurple = Color(0xFF9E5BFF);
  static const Color primaryPurple = Color(0xFF6B00FF);
  static const Color buttonPurple = Color(0xFF7A3FFF);
  static const Color accentPurple = Color(0xFFB895FF);

  // Additional colors for anatomy theme
  static const Color neuralBlue = Color(0xFF00D4FF);
  static const Color cardiacRed = Color(0xFFFF4757);
  static const Color musclePink = Color(0xFFFF6B8B);
}

class AnatomyGradients {
  static const LinearGradient background = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AnatomyColors.deepPurple, AnatomyColors.darkNavy],
  );

  static const LinearGradient logo = LinearGradient(
    colors: [AnatomyColors.primaryPurple, AnatomyColors.lightPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const RadialGradient glow = RadialGradient(
    radius: 0.7,
    colors: [
      Color(0xAA9E5BFF), // Light purple center glow
      Color(0x00000000), // Fade to transparent
    ],
  );
}