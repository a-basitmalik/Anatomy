import 'package:flutter/material.dart';

import '../theme/anatomy_colors.dart';
import 'dart:ui';

class AnatomyBackground extends StatelessWidget {
  const AnatomyBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main Gradient Background
        Container(
          decoration: const BoxDecoration(
            gradient: AnatomyGradients.background,
          ),
        ),

        // 💜 Subtle radial glow near top-right corner
        Positioned(
          top: -100,
          right: -60,
          child: Container(
            width: 350,
            height: 350,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: AnatomyGradients.glow,
            ),
          ),
        ),

        // 🌫 Optional blurred glow for more realism
        Positioned(
          top: -80,
          right: -30,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(
              width: 200,
              height: 200,
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}