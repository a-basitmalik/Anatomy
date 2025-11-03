import 'package:flutter/material.dart';
import 'screens/vr_anatomy_login_screen.dart';
import 'screens/student_dashboard.dart';

void main() {
  runApp(VREnatomyApp());
}

class VREnatomyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VR Anatomy Lab',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E2A),
        primaryColor: const Color(0xFF6B00FF),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6B00FF),
          secondary: Color(0xFF9E5BFF),
        ),
      ),
      home: const  VRAnatomyLoginScreen(), // Changed to dashboard for testing
      // home: const VRAnatomyLoginScreen(), // Use this for actual login flow
      debugShowCheckedModeBanner: false,
    );
  }
}