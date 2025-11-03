import 'package:flutter/material.dart';
import 'dart:ui';
import '../models/category.dart';
import '../models/anatomy_category.dart';
import '../models/quiz.dart';
import '../widgets/glass_card.dart';
import '../theme/anatomy_colors.dart';
import '../screens/parts_screen.dart';
import '../screens/quiz_screen.dart';

class CategoriesScreen extends StatefulWidget {
  final AnatomyCategory level;

  const CategoriesScreen({
    super.key,
    required this.level,
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // Static data for categories - replace with API call
  final List<Category> categories = [
    Category(
      categoryId: 1,
      categoryName: "Skeletal System",
      categoryShortDescription: "Bones, joints, and skeletal structure",
      levelId: 1,
      categoryImage: "assets/skeleton.png",
    ),
    Category(
      categoryId: 2,
      categoryName: "Muscular System",
      categoryShortDescription: "Muscles, tendons, and movement",
      levelId: 1,
      categoryImage: "assets/muscles.png",
    ),
    Category(
      categoryId: 3,
      categoryName: "Nervous System",
      categoryShortDescription: "Brain, nerves, and neural pathways",
      levelId: 1,
      categoryImage: "assets/brain.png",
    ),
    Category(
      categoryId: 4,
      categoryName: "Cardiovascular System",
      categoryShortDescription: "Heart, blood vessels, and circulation",
      levelId: 1,
      categoryImage: "assets/heart.png",
    ),
    Category(
      categoryId: 5,
      categoryName: "Respiratory System",
      categoryShortDescription: "Lungs, airways, and breathing",
      levelId: 1,
      categoryImage: "assets/lungs.png",
    ),
    Category(
      categoryId: 6,
      categoryName: "Digestive System",
      categoryShortDescription: "Stomach, intestines, and digestion",
      levelId: 1,
      categoryImage: "assets/stomach.png",
    ),
  ];

  // Level-wide quizzes
  final List<Quiz> levelQuizzes = [
    Quiz(
      quizId: 101,
      levelId: 1,
      quizType: "comprehensive_assessment",
      totalMarks: 200,
      totalQuestions: 20,
      completedQuestions: 0,
      score: 0,
    ),
    Quiz(
      quizId: 102,
      levelId: 1,
      quizType: "system_identification",
      totalMarks: 150,
      totalQuestions: 15,
      completedQuestions: 8,
      score: 75,
    ),
    Quiz(
      quizId: 103,
      levelId: 1,
      quizType: "practical_application",
      totalMarks: 100,
      totalQuestions: 10,
      completedQuestions: 10,
      score: 90,
    ),
  ];

  void _onCategoryTap(Category category) {
    // Navigate to Parts Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PartsScreen(category: category),
      ),
    );
  }

  void _onLevelQuizTap(Quiz quiz) {
    // Navigate to Quiz Screen for level-wide quiz
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizScreen(
          quiz: quiz,
          previousScreen: 'categories',
        ),
      ),
    );
  }

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
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                radius: 0.7,
                colors: [
                  Color(widget.level.color).withOpacity(0.3),
                  Color(0x00000000),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          // Back Button
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFF141936),
              border: Border.all(color: Colors.white24),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.level.level,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.level.title,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // Progress Indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  Color(widget.level.color),
                  Color(widget.level.color).withOpacity(0.7),
                ],
              ),
            ),
            child: Text(
              "${widget.level.progress}% Complete",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelQuizzesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8, bottom: 16),
          child: Text(
            "Level Quizzes",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Level Quizzes Cards
        ...levelQuizzes.map((quiz) => _buildLevelQuizCard(quiz)),

        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildLevelQuizCard(Quiz quiz) {
    return GestureDetector(
      onTap: () => _onLevelQuizTap(quiz),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: GlassCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Quiz Icon
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: quiz.progress == 100
                          ? const [Color(0xFF00FF88), Color(0xFF00CC6A)]
                          : const [Color(0xFF9E5BFF), Color(0xFF6B00FF)],
                    ),
                  ),
                  child: Icon(
                    quiz.progress == 100 ? Icons.assignment_turned_in : Icons.quiz_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                ),

                const SizedBox(width: 16),

                // Quiz Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getQuizTitle(quiz.quizType),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _getQuizDescription(quiz.quizType),
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // Quiz Details
                      Row(
                        children: [
                          _buildQuizDetail(Icons.question_answer, "${quiz.totalQuestions} Qs"),
                          const SizedBox(width: 12),
                          _buildQuizDetail(Icons.grade, "${quiz.totalMarks} Marks"),
                          const SizedBox(width: 12),
                          _buildQuizDetail(Icons.schedule, "45 mins"),
                        ],
                      ),
                    ],
                  ),
                ),

                // Progress and Action
                Column(
                  children: [
                    // Progress Circle
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Stack(
                        children: [
                          CircularProgressIndicator(
                            value: quiz.progress / 100,
                            strokeWidth: 4,
                            backgroundColor: Colors.white24,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              quiz.progress == 100 ? const Color(0xFF00FF88) : const Color(0xFF9E5BFF),
                            ),
                          ),
                          Center(
                            child: Text(
                              "${quiz.progress.toInt()}%",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Start Button
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFF7A3FFF),
                      ),
                      child: Text(
                        quiz.progress == 0 ? "Start" : "Retake",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 12),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  String _getQuizTitle(String quizType) {
    switch (quizType) {
      case "comprehensive_assessment":
        return "Comprehensive Assessment";
      case "system_identification":
        return "System Identification";
      case "practical_application":
        return "Practical Application";
      default:
        return "Level Quiz";
    }
  }

  String _getQuizDescription(String quizType) {
    switch (quizType) {
      case "comprehensive_assessment":
        return "Complete level assessment covering all systems";
      case "system_identification":
        return "Identify different anatomical systems and structures";
      case "practical_application":
        return "Apply your knowledge to practical scenarios";
      default:
        return "Test your knowledge of this level";
    }
  }

  Widget _buildCategoryCard(Category category, int index) {
    final colors = [
      [Color(0xFF00D4FF), Color(0xFF0099CC)],
      [Color(0xFFFF6B8B), Color(0xFFFF4757)],
      [Color(0xFF9E5BFF), Color(0xFF6B00FF)],
      [Color(0xFF00FF88), Color(0xFF00CC6A)],
      [Color(0xFFFFA500), Color(0xFFFF8C00)],
      [Color(0xFFAD66D5), Color(0xFF804399)],
    ];

    final colorPair = colors[index % colors.length];

    return GestureDetector(
      onTap: () => _onCategoryTap(category),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colorPair,
          ),
          boxShadow: [
            BoxShadow(
              color: colorPair[0].withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background Pattern
            Positioned(
              top: 10,
              right: 10,
              child: Opacity(
                opacity: 0.1,
                child: Icon(
                  _getCategoryIcon(category.categoryName),
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Category Icon and Name
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _getCategoryIcon(category.categoryName),
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          category.categoryName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  // Description
                  Text(
                    category.categoryShortDescription ?? '',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Progress and Action
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Progress
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "${_getRandomProgress()}% Learned",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Explore Button
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    if (categoryName.toLowerCase().contains('skeletal')) {
      return Icons.architecture;
    } else if (categoryName.toLowerCase().contains('muscular')) {
      return Icons.fitness_center;
    } else if (categoryName.toLowerCase().contains('nervous')) {
      return Icons.psychology;
    } else if (categoryName.toLowerCase().contains('cardio')) {
      return Icons.favorite;
    } else if (categoryName.toLowerCase().contains('respiratory')) {
      return Icons.air;
    } else if (categoryName.toLowerCase().contains('digestive')) {
      return Icons.restaurant;
    }
    return Icons.medical_services;
  }

  int _getRandomProgress() {
    // For demo purposes - replace with actual progress data
    final progresses = [25, 40, 60, 75, 90, 15];
    return progresses[categories.length % progresses.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          _buildBackground(),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Back Button and Level Info
                  _buildHeader(),

                  // Level Quizzes Section
                  _buildLevelQuizzesSection(),

                  // Categories Section
                  const Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 16),
                    child: Text(
                      "Anatomy Categories",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Categories List
                  ...categories.asMap().entries.map(
                        (entry) => _buildCategoryCard(entry.value, entry.key),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}