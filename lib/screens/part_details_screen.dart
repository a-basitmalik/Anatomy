import 'package:flutter/material.dart';
import 'dart:ui';
import '../models/part.dart';
import '../models/quiz.dart';
import '../models/query.dart';
import '../widgets/glass_card.dart';
import '../theme/anatomy_colors.dart';
import '../screens/quiz_screen.dart';
class PartDetailsScreen extends StatefulWidget {
  final Part part;

  const PartDetailsScreen({
    super.key,
    required this.part,
  });

  @override
  State<PartDetailsScreen> createState() => _PartDetailsScreenState();
}

class _PartDetailsScreenState extends State<PartDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _queryController = TextEditingController();

  // Static data - replace with API calls
  final List<Quiz> quizzes = [
    Quiz(
      quizId: 1,
      partId: 1,
      quizType: "identification",
      totalMarks: 100,
      totalQuestions: 10,
      completedQuestions: 7,
      score: 85,
    ),
    Quiz(
      quizId: 2,
      partId: 1,
      quizType: "multiple_choice",
      totalMarks: 50,
      totalQuestions: 5,
      completedQuestions: 5,
      score: 90,
    ),
    Quiz(
      quizId: 3,
      partId: 1,
      quizType: "practical",
      totalMarks: 150,
      totalQuestions: 15,
      completedQuestions: 0,
      score: 0,
    ),
  ];

  final List<Query> queries = [
    Query(
      queryId: 1,
      partId: 1,
      question: "What are the main bones that form the skull?",
      answer: "The skull is formed by 22 bones, including the cranial bones (frontal, parietal, temporal, occipital, sphenoid, ethmoid) and facial bones.",
      askedAt: DateTime.now().subtract(const Duration(days: 2)),
      answeredAt: DateTime.now().subtract(const Duration(days: 1)),
      status: "answered",
    ),
    Query(
      queryId: 2,
      partId: 1,
      question: "How does the skull protect the brain?",
      answer: null,
      askedAt: DateTime.now().subtract(const Duration(hours: 5)),
      answeredAt: null,
      status: "pending",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _queryController.dispose();
    super.dispose();
  }

  void _launchVRExperience() {
    // TODO: Launch VR experience
    print('Launching VR for: ${widget.part.partName}');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1F3D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Enter VR Experience',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Prepare to explore ${widget.part.partName} in immersive virtual reality...',
          style: const TextStyle(color: Colors.white70),
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
            child: const Text('Enter VR'),
          ),
        ],
      ),
    );
  }

  void _watchVideo() {
    // TODO: Play video
    print('Playing video for: ${widget.part.partName}');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Playing video: ${widget.part.partName}'),
        backgroundColor: const Color(0xFF7A3FFF),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _startQuiz(Quiz quiz) {
    // Navigate to Quiz Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizScreen(
          quiz: quiz,
          previousScreen: 'parts', // or 'categories', 'levels' based on context
        ),
      ),
    );
  }
  void _submitQuery() {
    if (_queryController.text.trim().isEmpty) return;

    final newQuery = Query(
      queryId: queries.length + 1,
      partId: widget.part.partId,
      question: _queryController.text.trim(),
      askedAt: DateTime.now(),
      status: "pending",
    );

    setState(() {
      queries.insert(0, newQuery);
      _queryController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Question submitted successfully!'),
        backgroundColor: const Color(0xFF7A3FFF),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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

        // Purple glow effect
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
                  widget.part.partName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.part.shortDescription ?? 'Anatomical Part Details',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartOverview() {
    return Column(
      children: [
        // Part Image Section
        Container(
          width: double.infinity,
          height: 200,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF9E5BFF), Color(0xFF6B00FF)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF9E5BFF).withOpacity(0.3),
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
                    _getPartIcon(widget.part.partName),
                    size: 120,
                    color: Colors.white,
                  ),
                ),
              ),

              // Part Icon
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    _getPartIcon(widget.part.partName),
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),

              // Progress Indicator
              Positioned(
                bottom: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black.withOpacity(0.3),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Text(
                    "${widget.part.progress}% Learned",
                    style: const TextStyle(
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

        // Part Name in Liquid Glass Card
        GlassCard(
          borderRadius: 15,
          blur: 15,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  widget.part.partName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.part.shortDescription ?? 'Anatomical Structure',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Full Description in Glass Card
        GlassCard(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Detailed Description",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.part.fullDescription ?? 'No detailed description available for this anatomical part. Explore through VR experience to learn more.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 16),

                // Additional Info Section
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF141936).withOpacity(0.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF7A3FFF), Color(0xFF9E5BFF)],
                          ),
                        ),
                        child: const Icon(
                          Icons.medical_services,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Anatomical Focus",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              _getAnatomicalFocus(widget.part.partName),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
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
          ),
        ),

        const SizedBox(height: 20),

        // Action Buttons Section
        GlassCard(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  "Interactive Learning",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Choose your preferred learning method",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF7A3FFF), Color(0xFF9E5BFF)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF7A3FFF).withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: _launchVRExperience,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.vrpano_outlined, color: Colors.white, size: 24),
                                SizedBox(height: 4),
                                Text(
                                  'VR Experience',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: const Color(0xFF7A3FFF), width: 2),
                          color: Colors.transparent,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF7A3FFF).withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: _watchVideo,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.play_circle_outline, color: Color(0xFF7A3FFF), size: 24),
                                SizedBox(height: 4),
                                Text(
                                  'Watch Video',
                                  style: TextStyle(
                                    color: Color(0xFF7A3FFF),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Quick Stats
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF141936).withOpacity(0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(Icons.quiz_outlined, "${quizzes.length}", "Quizzes"),
                      _buildStatItem(Icons.question_answer, "${queries.length}", "Queries"),
                      _buildStatItem(Icons.schedule, "${widget.part.progress}%", "Progress"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

// Helper method for anatomical focus
  String _getAnatomicalFocus(String partName) {
    final name = partName.toLowerCase();
    if (name.contains('skull')) return "Cranial & Facial Bones";
    if (name.contains('spine')) return "Vertebral Column";
    if (name.contains('rib')) return "Thoracic Protection";
    if (name.contains('pelvis')) return "Pelvic Structure";
    if (name.contains('femur')) return "Long Bone Anatomy";
    return "Anatomical Structure";
  }

// Helper method for stats
  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF7A3FFF), Color(0xFF9E5BFF)],
            ),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
  Widget _buildQuizCard(Quiz quiz) {
    return GlassCard(
      onTap: () => _startQuiz(quiz),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Quiz Icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: quiz.progress == 100
                      ? const [Color(0xFF00FF88), Color(0xFF00CC6A)]
                      : const [Color(0xFF9E5BFF), Color(0xFF6B00FF)],
                ),
              ),
              child: Icon(
                quiz.progress == 100 ? Icons.check : Icons.quiz_outlined,
                color: Colors.white,
                size: 24,
              ),
            ),

            const SizedBox(width: 16),

            // Quiz Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quiz.formattedType,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${quiz.totalQuestions} Questions • ${quiz.totalMarks} Marks",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Progress
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.white24,
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: quiz.progress / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                gradient: LinearGradient(
                                  colors: quiz.progress == 100
                                      ? const [Color(0xFF00FF88), Color(0xFF00CC6A)]
                                      : const [Color(0xFF9E5BFF), Color(0xFF6B00FF)],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${quiz.progress.toInt()}%",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Score if completed
            if (quiz.progress > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFF141936),
                ),
                child: Text(
                  "${quiz.score.toInt()}%",
                  style: TextStyle(
                    color: quiz.score >= 70 ? const Color(0xFF00FF88) : const Color(0xFFFF6B8B),
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

  Widget _buildQueryCard(Query query) {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: query.isAnswered
                        ? const Color(0xFF00FF88).withOpacity(0.2)
                        : const Color(0xFFFF6B8B).withOpacity(0.2),
                  ),
                  child: Icon(
                    query.isAnswered ? Icons.check : Icons.schedule,
                    color: query.isAnswered ? const Color(0xFF00FF88) : const Color(0xFFFF6B8B),
                    size: 16,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    query.question,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),

            // Answer if available
            if (query.isAnswered && query.answer != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFF141936),
                ),
                child: Text(
                  query.answer!,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ),
            ],

            // Status and Date
            const SizedBox(height: 12),
            Text(
              query.isAnswered
                  ? 'Answered ${_formatDate(query.answeredAt!)}'
                  : 'Pending answer',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
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
                      Tab(text: 'Overview'),
                      Tab(text: 'Quizzes'),
                      Tab(text: 'Queries'),
                    ],
                  ),
                ),

                // Tab Content
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Overview Tab
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            _buildPartOverview(),
                          ],
                        ),
                      ),

                      // Quizzes Tab
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            ...quizzes.map((quiz) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _buildQuizCard(quiz),
                            )),
                          ],
                        ),
                      ),

                      // Queries Tab
                      Column(
                        children: [
                          // Ask Question Section
                          GlassCard(
                            margin: const EdgeInsets.all(20),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Ask a Question',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  TextField(
                                    controller: _queryController,
                                    maxLines: 3,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: 'Type your question about ${widget.part.partName}...',
                                      hintStyle: const TextStyle(color: Colors.white38),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFF141936),
                                      contentPadding: const EdgeInsets.all(16),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Container(
                                    width: double.infinity,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFF7A3FFF), Color(0xFF9E5BFF)],
                                      ),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: _submitQuery,
                                        child: const Center(
                                          child: Text(
                                            'Submit Question',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Questions List
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  ...queries.map((query) => Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: _buildQueryCard(query),
                                  )),
                                ],
                              ),
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
        ],
      ),
    );
  }
}