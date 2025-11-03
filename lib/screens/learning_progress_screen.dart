import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';
import '../theme/anatomy_colors.dart';

class LearningProgressScreen extends StatefulWidget {
  const LearningProgressScreen({super.key});

  @override
  State<LearningProgressScreen> createState() => _LearningProgressScreenState();
}

class _LearningProgressScreenState extends State<LearningProgressScreen> {
  final String studentName = "Alex Johnson";
  final double overallProgress = 78.5;

  // Sample data for quizzes
  final Map<String, List<QuizItem>> quizData = {
    "Beginner Level": [
      QuizItem("Skeletal System Basics", 85, true, "2 days ago"),
      QuizItem("Muscle Types", 72, true, "1 week ago"),
      QuizItem("Basic Organs", 0, false, "Not attempted"),
    ],
    "Intermediate Level": [
      QuizItem("Nervous System", 91, true, "2 weeks ago"),
      QuizItem("Cardiovascular System", 65, true, "3 weeks ago"),
      QuizItem("Respiratory System", 0, false, "Not attempted"),
      QuizItem("Digestive System", 78, true, "1 month ago"),
    ],
    "Advanced Level": [
      QuizItem("Endocrine System", 0, false, "Not attempted"),
      QuizItem("Lymphatic System", 82, true, "2 months ago"),
    ],
    "Expert Level": [
      QuizItem("Micro Anatomy", 0, false, "Not attempted"),
      QuizItem("Histology", 0, false, "Not attempted"),
    ],
  };

  Widget _buildBackground() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1B103E),
                Color(0xFF0D0A1F),
                Color(0xFF050613),
              ],
              stops: [0.0, 0.6, 1.0],
            ),
          ),
        ),
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

  Widget _buildStatsHeader() {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Overall Progress
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Learning Progress",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "${overallProgress.toInt()}% Complete",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Stack(
                    children: [
                      CircularProgressIndicator(
                        value: overallProgress / 100,
                        strokeWidth: 8,
                        backgroundColor: Colors.white24,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00FF88)),
                      ),
                      Center(
                        child: Text(
                          "${overallProgress.toInt()}%",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem("Quizzes Taken", "12", Color(0xFF00D4FF)),
                _buildStatItem("Average Score", "78%", Color(0xFF00FF88)),
                _buildStatItem("Highest Score", "91%", Color(0xFFFF6B8B)),
                _buildStatItem("Time Spent", "18h", Color(0xFF9E5BFF)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, Color color) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withOpacity(0.5)),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 10,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildQuizSection(String level, List<QuizItem> quizzes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Text(
            level,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...quizzes.map((quiz) => _buildQuizItem(quiz)),
      ],
    );
  }

  Widget _buildQuizItem(QuizItem quiz) {
    return GlassCard(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Status Indicator
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: quiz.isSolved
                    ? _getScoreColor(quiz.score)
                    : Colors.grey,
              ),
            ),
            SizedBox(width: 16),

            // Quiz Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: quiz.isSolved
                    ? _getScoreColor(quiz.score).withOpacity(0.2)
                    : Colors.grey.withOpacity(0.2),
              ),
              child: Icon(
                quiz.isSolved ? Icons.quiz : Icons.quiz_outlined,
                color: quiz.isSolved
                    ? _getScoreColor(quiz.score)
                    : Colors.grey,
                size: 20,
              ),
            ),
            SizedBox(width: 16),

            // Quiz Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quiz.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    quiz.isSolved
                        ? "Score: ${quiz.score}% • ${quiz.timeAgo}"
                        : "Not attempted",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Score Badge
            if (quiz.isSolved)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: _getScoreColor(quiz.score).withOpacity(0.2),
                  border: Border.all(color: _getScoreColor(quiz.score)),
                ),
                child: Text(
                  "${quiz.score}%",
                  style: TextStyle(
                    color: _getScoreColor(quiz.score),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withOpacity(0.2),
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  "Not Taken",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getScoreColor(int score) {
    if (score >= 90) return Color(0xFF00FF88);
    if (score >= 80) return Color(0xFF00D4FF);
    if (score >= 70) return Color(0xFFFF6B8B);
    return Color(0xFFFF4757);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          _buildBackground(),

          // Content
          Column(
            children: [
              // Custom App Bar
              Container(
                padding: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      "Learning Progress",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Stats Header
                      _buildStatsHeader(),
                      SizedBox(height: 30),

                      // Quiz Sections
                      ...quizData.entries.map(
                              (entry) => _buildQuizSection(entry.key, entry.value)
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QuizItem {
  final String title;
  final int score;
  final bool isSolved;
  final String timeAgo;

  QuizItem(this.title, this.score, this.isSolved, this.timeAgo);
}