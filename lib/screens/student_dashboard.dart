import 'package:flutter/material.dart';
import '../models/quiz_score.dart';
import '../models/anatomy_category.dart';
import '../widgets/glass_card.dart';
import '../widgets/category_card.dart';
import '../widgets/score_item.dart';
import '../widgets/dashboard_header.dart';
import '../theme/anatomy_colors.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  final String studentName = "Alex Johnson";
  final double overallProgress = 78.5;

  final List<QuizScore> recentScores = [
    QuizScore("Skeletal System", 85, "A", "2 days ago"),
    QuizScore("Muscular System", 72, "B", "1 week ago"),
    QuizScore("Nervous System", 91, "A+", "2 weeks ago"),
  ];

  final List<AnatomyCategory> categories = [
    AnatomyCategory("Beginner", "Basic Systems", 25, Icons.accessible, 0xFF00D4FF),
    AnatomyCategory("Intermediate", "Organs & Tissues", 50, Icons.heart_broken, 0xFFFF6B8B),
    AnatomyCategory("Advanced", "Complex Systems", 15, Icons.psychology, 0xFF9E5BFF),
    AnatomyCategory("Expert", "Micro Anatomy", 10, Icons.biotech, 0xFF00FF88),
  ];

  void _onCategoryTap(AnatomyCategory category) {
    // TODO: Navigate to category detail screen
    print('Category tapped: ${category.level}');

    // Show temporary dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1F3D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          category.level,
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          'Opening ${category.title} content...',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(color: Color(0xFF9E5BFF)),
            ),
          ),
        ],
      ),
    );
  }

  void _onNotificationTap() {
    // TODO: Navigate to notifications screen
    print('Notifications tapped');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('No new notifications'),
        backgroundColor: const Color(0xFF7A3FFF),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _onVRGuideTap() {
    // TODO: Launch VR experience
    print('VR Guide tapped');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1F3D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Launch VR Experience',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Prepare to enter immersive VR anatomy lab...',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Actually launch VR
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7A3FFF),
            ),
            child: const Text('Launch'),
          ),
        ],
      ),
    );
  }

  void _onQueriesTap() {
    // TODO: Navigate to queries screen
    print('Queries tapped');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Opening help center...'),
        backgroundColor: const Color(0xFF00D4FF),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        // Updated Linear Gradient Background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1B103E), // Top color - lighter purple
                Color(0xFF0D0A1F), // Middle dark
                Color(0xFF050613), // Bottom - darkest
              ],
              stops: [0.0, 0.6, 1.0],
            ),
          ),
        ),

        // Keep only the top-right purple glow (removed the blue bottom glow)
        Positioned(
          top: -100,
          right: -60,
          child: Container(
            width: 350,
            height: 350,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                radius: 0.7,
                colors: [
                  Color(0xAA9E5BFF),
                  Color(0x00000000),
                ],
              ),
            ),
          ),
        ),

        // Subtle overlay for more depth
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.3),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSection() {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Learning Progress",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Overall Progress Circle
            Row(
              children: [
                // Progress Circle
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Stack(
                    children: [
                      CircularProgressIndicator(
                        value: overallProgress / 100,
                        strokeWidth: 8,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00FF88)),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${overallProgress.toInt()}%",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Overall",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 20),

                // Recent Scores
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Recent Scores",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...recentScores.map((score) => ScoreItem(score: score)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 16),
          child: Text(
            "Anatomy Levels",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryCard(
              category: categories[index],
              onTap: () => _onCategoryTap(categories[index]),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBottomSection() {
    return Row(
      children: [
        // VR Guide
        Expanded(
          child: GlassCard(
            onTap: _onVRGuideTap,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6B00FF), Color(0xFF9E5BFF)],
                      ),
                    ),
                    child: const Icon(
                      Icons.vrpano_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "VR Guide",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Start immersive learning",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF7A3FFF),
                    ),
                    child: const Center(
                      child: Text(
                        "Launch VR",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Queries
        Expanded(
          child: GlassCard(
            onTap: _onQueriesTap,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00D4FF), Color(0xFF00FF88)],
                      ),
                    ),
                    child: const Icon(
                      Icons.help_outline,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Queries",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Get help from experts",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF00D4FF)),
                    ),
                    child: const Center(
                      child: Text(
                        "Ask Question",
                        style: TextStyle(
                          color: Color(0xFF00D4FF),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          _buildBackground(),

          // Content
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Greeting and Notifications
                DashboardHeader(
                  studentName: studentName,
                  onNotificationTap: _onNotificationTap,
                ),

                const SizedBox(height: 30),

                // Student Progress Section
                _buildProgressSection(),

                const SizedBox(height: 30),

                // Categories Levels
                _buildCategoriesSection(),

                const SizedBox(height: 30),

                // VR Guide & Queries
                _buildBottomSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}