import 'package:flutter/material.dart';
import 'dart:ui';
import '../widgets/anatomy_background.dart';
import '../widgets/gradient_checkbox.dart';
import '../widgets/social_login_button.dart';
import '../theme/anatomy_colors.dart';
import '../screens/student_dashboard.dart'; // Add this import

class VRAnatomyLoginScreen extends StatefulWidget {
  const VRAnatomyLoginScreen({super.key});

  @override
  State<VRAnatomyLoginScreen> createState() => _VRAnatomyLoginScreenState();
}

class _VRAnatomyLoginScreenState extends State<VRAnatomyLoginScreen> {
  bool _obscurePassword = true;
  bool _rememberMe = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Check for specific credentials
    if (email == "zainabtouseef@itu.edu.pk" && password == "zainab123") {
      // Navigate to Student Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => StudentDashboard(),
        ),
      );
    } else {
      // Show error for invalid credentials
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Invalid email or password'),
          backgroundColor: const Color(0xFFFF6B8B),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          const AnatomyBackground(),

          // Login Content
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),

                // 🧠 VR Anatomy Logo + App Name
                Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF6B00FF), Color(0xFF9E5BFF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xAA9E5BFF),
                            blurRadius: 25,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.psychology, color: Colors.white, size: 35),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "VR Anatomy Lab",
                      style: TextStyle(
                        color: Color(0xFFB895FF),
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                // 🖋️ Title
                const Text(
                  "Enter the Human Body in VR",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Explore human anatomy in immersive virtual reality.\nStudy organs, systems, and biological structures.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 40),

                // ✉️ Email
                _buildTextField(
                  label: "Email",
                  hint: "student.anatomy@university.edu",
                  icon: Icons.email_outlined,
                  controller: _emailController,
                ),

                const SizedBox(height: 20),

                // 🔑 Password
                _buildTextField(
                  label: "Password",
                  hint: "••••••••",
                  icon: Icons.lock_outline,
                  isPassword: true,
                  controller: _passwordController,
                ),

                const SizedBox(height: 30),

                // 🌈 Enter VR Lab Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7A3FFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 8,
                      shadowColor: const Color(0xAA9E5BFF),
                    ),
                    child: const Text(
                      "Enter VR Lab",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // 🔘 Remember + Forgot
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GradientCheckbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                      label: "Remember me",
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement forgot password
                        print('Forgot password tapped');
                      },
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(color: Color(0xFF9E5BFF)),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Divider
                Row(
                  children: const [
                    Expanded(
                      child: Divider(color: Colors.white24, thickness: 1),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("Or", style: TextStyle(color: Colors.white54)),
                    ),
                    Expanded(
                      child: Divider(color: Colors.white24, thickness: 1),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 🧠 Social Buttons
                SocialLoginButton(
                  text: "Sign in with Google",
                  icon: Icons.g_mobiledata,
                  onPressed: () {
                    // TODO: Implement Google sign in
                    print('Google sign in');
                  },
                ),
                const SizedBox(height: 10),
                SocialLoginButton(
                  text: "Continue with Apple",
                  icon: Icons.apple,
                  onPressed: () {
                    // TODO: Implement Apple sign in
                    print('Apple sign in');
                  },
                ),

                const SizedBox(height: 30),

                // 🆕 Sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "New to VR Anatomy? ",
                      style: TextStyle(color: Colors.white70),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: Implement sign up navigation
                        print('Sign up tapped');
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Color(0xFF9E5BFF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                // Demo Credentials Hint
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Auto-fill demo credentials
                    _emailController.text = "zainabtouseef@itu.edu.pk";
                    _passwordController.text = "zainab123";
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.1),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lightbulb_outline, color: Color(0xFF00D4FF), size: 16),
                        SizedBox(width: 8),
                        Text(
                          "Tap to auto-fill demo credentials",
                          style: TextStyle(
                            color: Color(0xFF00D4FF),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF141936),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword ? _obscurePassword : false,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white38),
              prefixIcon: Icon(icon, color: Colors.white38),
              suffixIcon: isPassword
                  ? IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white38,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}