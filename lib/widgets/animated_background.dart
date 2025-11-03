import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:math';

class AnimatedAnatomyBackground extends StatefulWidget {
  @override
  _AnimatedAnatomyBackgroundState createState() => _AnimatedAnatomyBackgroundState();
}

class _AnimatedAnatomyBackgroundState extends State<AnimatedAnatomyBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: _pulseAnimation.value,
              colors: [
                Color(0xFF0A0E2A),
                Color(0xFF1A1F3D),
                Color(0xFF2D1B69),
              ],
              stops: [0.1, 0.5, 1.0],
            ),
          ),
          child: CustomPaint(
            painter: _AnatomyGridPainter(animationValue: _controller.value),
          ),
        );
      },
    );
  }
}

class _AnatomyGridPainter extends CustomPainter {
  final double animationValue;

  _AnatomyGridPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw grid
    for (double x = 0; x < size.width; x += 30) {
      for (double y = 0; y < size.height; y += 30) {
        final offset = Offset(x, y);
        canvas.drawCircle(offset, 1, paint);
      }
    }

    // Draw floating anatomy elements
    _drawFloatingElements(canvas, size);
  }

  void _drawFloatingElements(Canvas canvas, Size size) {
    final elements = [
      _FloatingElement(Offset(size.width * 0.2, size.height * 0.3), 20, 0.0),
      _FloatingElement(Offset(size.width * 0.8, size.height * 0.6), 15, 2.0),
      _FloatingElement(Offset(size.width * 0.4, size.height * 0.8), 25, 4.0),
    ];

    for (var element in elements) {
      final animatedOffset = element.offset.translate(
        0,
        sin(animationValue * 2 * 3.14 + element.phase) * 10,
      );

      final paint = Paint()
        ..color = Color(0xFF00D4FF).withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawCircle(animatedOffset, element.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _FloatingElement {
  final Offset offset;
  final double radius;
  final double phase;

  _FloatingElement(this.offset, this.radius, this.phase);
}