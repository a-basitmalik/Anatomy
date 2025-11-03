import 'package:flutter/material.dart';
import 'dart:ui';
import '../models/part.dart';
import '../models/category.dart';
import '../models/quiz.dart';
import '../widgets/glass_card.dart';
import '../theme/anatomy_colors.dart';
import '../screens/part_details_screen.dart';
import '../screens/quiz_screen.dart';

class PartsScreen extends StatefulWidget {
  final Category category;

  const PartsScreen({
    super.key,
    required this.category,
  });

  @override
  State<PartsScreen> createState() => _PartsScreenState();
}

class _PartsScreenState extends State<PartsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Static data for parts - replace with API call
  final List<Part> parts = [
    Part(
      partId: 1,
      categoryId: 1,
      partName: "Skull",
      shortDescription: "Bony structure that forms the head",
      fullDescription: "The skull is a bony structure that forms the head in vertebrates. It supports the structures of the face and provides a protective cavity for the brain.",
      partImage: "assets/skull.png",
      videoLink: "https://example.com/skull-video",
      vrLink: "https://example.com/skull-vr",
      progress: 75,
    ),
    Part(
      partId: 2,
      categoryId: 1,
      partName: "Spine",
      shortDescription: "Vertebral column and spinal cord",
      fullDescription: "The spine, also known as the vertebral column, is the central support structure that connects different parts of the musculoskeletal system.",
      partImage: "assets/spine.png",
      videoLink: "https://example.com/spine-video",
      vrLink: "https://example.com/spine-vr",
      progress: 60,
    ),
    Part(
      partId: 3,
      categoryId: 1,
      partName: "Rib Cage",
      shortDescription: "Protective bony structure around chest",
      fullDescription: "The rib cage is an arrangement of bones in the thorax of most vertebrates. It surrounds the chest and protects vital organs like the heart and lungs.",
      partImage: "assets/ribcage.png",
      videoLink: "https://example.com/ribcage-video",
      vrLink: "https://example.com/ribcage-vr",
      progress: 40,
    ),
    Part(
      partId: 4,
      categoryId: 1,
      partName: "Pelvis",
      shortDescription: "Bony structure connecting spine to legs",
      fullDescription: "The pelvis is the lower part of the trunk, between the abdomen and the thighs. It provides attachment for muscles and supports the abdominal organs.",
      partImage: "assets/pelvis.png",
      videoLink: "https://example.com/pelvis-video",
      vrLink: "https://example.com/pelvis-vr",
      progress: 25,
    ),
    Part(
      partId: 5,
      categoryId: 1,
      partName: "Femur",
      shortDescription: "Longest and strongest bone in human body",
      fullDescription: "The femur, or thigh bone, is the longest, strongest, and heaviest bone in the human body. It extends from the hip to the knee.",
      partImage: "assets/femur.png",
      videoLink: "https://example.com/femur-video",
      vrLink: "https://example.com/femur-vr",
      progress: 90,
    ),
  ];

  // Category Quizzes
  final List<Quiz> categoryQuizzes = [
    Quiz(
      quizId: 201,
      categoryId: 1,
      quizType: "system_mastery",
      totalMarks: 100,
      totalQuestions: 10,
      completedQuestions: 6,
      score: 80,
    ),
    Quiz(
      quizId: 202,
      categoryId: 1,
      quizType: "identification",
      totalMarks: 150,
      totalQuestions: 15,
      completedQuestions: 15,
      score: 92,
    ),
    Quiz(
      quizId: 203,
      categoryId: 1,
      quizType: "practical_test",
      totalMarks: 200,
      totalQuestions: 20,
      completedQuestions: 0,
      score: 0,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onPartTap(Part part) {
    // Navigate to Part Details Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PartDetailsScreen(part: part),
      ),
    );
  }

  void _onCategoryQuizTap(Quiz quiz) {
    // Navigate to Quiz Screen for category quiz
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizScreen(
          quiz: quiz,
          previousScreen: 'parts',
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        // Updated Linear Gradient Background - Same as StudentDashboard
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

        // Top-right purple glow - Same as StudentDashboard
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

        // Subtle overlay for more depth - Same as StudentDashboard
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
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
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
                  widget.category.categoryName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.category.categoryShortDescription ?? 'Explore anatomical parts',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Parts Count
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFF141936),
              border: Border.all(color: Colors.white24),
            ),
            child: Text(
              "${parts.length} Parts",
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

  Widget _buildOverallProgress() {
    final totalProgress = parts.isEmpty ? 0 : parts.map((p) => p.progress).reduce((a, b) => a + b) ~/ parts.length;

    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Category Progress",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "$totalProgress% Complete",
                  style: const TextStyle(
                    color: Color(0xFF9E5BFF),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.white24,
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: totalProgress / 100,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF9E5BFF), Color(0xFF6B00FF)],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Completed ${parts.where((p) => p.progress == 100).length} of ${parts.length} parts",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPartCard(Part part, int index) {
    final colors = [
      [Color(0xFF00D4FF), Color(0xFF0099CC)],
      [Color(0xFFFF6B8B), Color(0xFFFF4757)],
      [Color(0xFF9E5BFF), Color(0xFF6B00FF)],
      [Color(0xFF00FF88), Color(0xFF00CC6A)],
      [Color(0xFFFFA500), Color(0xFFFF8C00)],
    ];

    final colorPair = colors[index % colors.length];

    return GestureDetector(
      onTap: () => _onPartTap(part),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Stack(
          children: [
            // Main Card
            GlassCard(
              borderRadius: 20,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Part Image/Icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: colorPair,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: colorPair[0].withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        _getPartIcon(part.partName),
                        color: Colors.white,
                        size: 30,
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Part Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            part.partName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            part.shortDescription ?? '',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 8),

                          // Progress Bar
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Progress",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    "${part.progress}%",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.white24,
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: part.progress / 100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      gradient: LinearGradient(
                                        colors: colorPair,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // VR Badge if available
                    if (part.vrLink != null && part.vrLink!.isNotEmpty)
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6B00FF), Color(0xFF9E5BFF)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6B00FF).withOpacity(0.5),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.vrpano_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Completion Badge
            if (part.progress == 100)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF00FF88),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryQuizCard(Quiz quiz) {
    return GestureDetector(
      onTap: () => _onCategoryQuizTap(quiz),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: GlassCard(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Quiz Icon
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    gradient: LinearGradient(
                      colors: quiz.progress == 100
                          ? const [Color(0xFF00FF88), Color(0xFF00CC6A)]
                          : const [Color(0xFF9E5BFF), Color(0xFF6B00FF)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (quiz.progress == 100
                            ? const Color(0xFF00FF88)
                            : const Color(0xFF9E5BFF)).withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    quiz.progress == 100 ? Icons.assignment_turned_in : Icons.quiz_outlined,
                    color: Colors.white,
                    size: 32,
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
                      ),
                      const SizedBox(height: 12),

                      // Quiz Stats
                      Row(
                        children: [
                          _buildQuizStat(Icons.question_answer, "${quiz.totalQuestions} Questions"),
                          const SizedBox(width: 16),
                          _buildQuizStat(Icons.grade, "${quiz.totalMarks} Marks"),
                          const SizedBox(width: 16),
                          // _buildQuizStat(Icons.schedule, "30 mins"),
                        ],
                      ),
                    ],
                  ),
                ),

                // Progress and Score
                Column(
                  children: [
                    // Progress Circle
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Stack(
                        children: [
                          CircularProgressIndicator(
                            value: quiz.progress / 100,
                            strokeWidth: 6,
                            backgroundColor: Colors.white24,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              quiz.progress == 100 ? const Color(0xFF00FF88) : const Color(0xFF9E5BFF),
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${quiz.progress.toInt()}%",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                if (quiz.progress > 0)
                                  Text(

                                    "${quiz.score.toInt()}%",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 10,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Action Button
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF7A3FFF), Color(0xFF9E5BFF)],
                        ),
                      ),
                      child: Text(
                        quiz.progress == 0 ? "Start Quiz" : "Retake",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
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

  Widget _buildQuizStat(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 14),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  String _getQuizTitle(String quizType) {
    switch (quizType) {
      case "system_mastery":
        return "System Mastery Test";
      case "identification":
        return "Anatomy Identification";
      case "practical_test":
        return "Practical Application";
      default:
        return "Category Quiz";
    }
  }

  String _getQuizDescription(String quizType) {
    switch (quizType) {
      case "system_mastery":
        return "Comprehensive test of ${widget.category.categoryName}";
      case "identification":
        return "Identify structures within ${widget.category.categoryName}";
      case "practical_test":
        return "Apply knowledge to practical scenarios";
      default:
        return "Test your ${widget.category.categoryName} knowledge";
    }
  }

  IconData _getPartIcon(String partName) {
    final name = partName.toLowerCase();
    if (name.contains('skull')) return Icons.psychology;
    if (name.contains('spine')) return Icons.line_axis;
    if (name.contains('rib')) return Icons.grid_on;
    if (name.contains('pelvis')) return Icons.circle;
    if (name.contains('femur')) return Icons.straighten;
    return Icons.architecture;
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
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: _buildHeader(),
                ),

                // Overall Progress
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildOverallProgress(),
                ),

                const SizedBox(height: 20),

                // Tab Bar
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF141936),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF9E5BFF), Color(0xFF6B00FF)],
                      ),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white70,
                    tabs: const [
                      Tab(text: 'Anatomy Parts'),
                      Tab(text: 'Category Quizzes'),
                    ],
                  ),
                ),

                // Tab Content
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Parts Tab
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            ...parts.asMap().entries.map(
                                  (entry) => _buildPartCard(entry.value, entry.key),
                            ),
                          ],
                        ),
                      ),

                      // Quizzes Tab
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            // Quiz Section Header
                            const Padding(
                              padding: EdgeInsets.only(bottom: 16),
                              child: Text(
                                "Test Your Knowledge",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            Text(
                              "Take quizzes to reinforce your understanding of ${widget.category.categoryName}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Quiz Cards
                            ...categoryQuizzes.map((quiz) => _buildCategoryQuizCard(quiz)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}