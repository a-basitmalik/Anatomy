import 'package:flutter/material.dart';

class AnatomyIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;

  const AnatomyIcon({
    Key? key,
    required this.icon,
    this.size = 24,
    this.color = const Color(0xFF00D4FF),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [color, Color(0xFF00FF88)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Icon(icon, size: size, color: Colors.white),
    );
  }
}