import 'package:flutter/material.dart';
import 'dart:ui';
import '../models/quiz.dart';
import '../models/quiz_question.dart';
import '../widgets/glass_card.dart';
import '../theme/anatomy_colors.dart';

class QuizScreen extends StatefulWidget {
  final Quiz quiz;
  final String previousScreen; // 'parts', 'categories', 'levels'

  const QuizScreen({
    super.key,
    required this.quiz,
    required this.previousScreen,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  Map<int, String?> _userAnswers = {};
  bool _isSubmitted = false;

  // Static data - replace with API call
  final List<QuizQuestion> questions = [
    QuizQuestion(
      questionId: 1,
      question: "Which bone forms the forehead and the upper part of the eye sockets?",
      questionImage: "assets/skull_front.png",
      questionMarks: 10,
      questionNumber: 1,
      questionType: "MCQ",
      quizId: 1,
      correctOption: "A",
      optionA: "Frontal Bone",
      optionB: "Parietal Bone",
      optionC: "Temporal Bone",
      optionD: "Occipital Bone",
    ),
    QuizQuestion(
      questionId: 2,
      question: "Identify the bone marked in the image below:",
      questionImage: "assets/mandible.png",
      questionMarks: 15,
      questionNumber: 2,
      questionType: "identification",
      quizId: 1,
      correctOption: "Mandible",
    ),
    QuizQuestion(
      questionId: 3,
      question: "How many bones make up the human skull?",
      questionMarks: 10,
      questionNumber: 3,
      questionType: "MCQ",
      quizId: 1,
      correctOption: "B",
      optionA: "20",
      optionB: "22",
      optionC: "24",
      optionD: "26",
    ),
    QuizQuestion(
      questionId: 4,
      question: "Describe the function of the sagittal suture:",
      questionMarks: 15,
      questionNumber: 4,
      questionType: "practical",
      quizId: 1,
      correctOption: "Connects parietal bones",
    ),
  ];

  void _selectAnswer(String answer) {
    setState(() {
      _userAnswers[_currentQuestionIndex] = answer;
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _submitQuiz() {
    setState(() {
      _isSubmitted = true;
    });

    // Show success dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _buildSuccessDialog(),
    );
  }

  Widget _buildSuccessDialog() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: GlassCard(
        borderRadius: 25,
        blur: 20,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00FF88), Color(0xFF00CC6A)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00FF88).withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Quiz Submitted!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Your responses have been recorded successfully",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7A3FFF), Color(0xFF9E5BFF)],
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      Navigator.pop(context); // Close dialog
                      Navigator.pop(context); // Return to previous screen
                    },
                    child:  Center(
                      child: Text(
                        "Return to ${_getPreviousScreenName()}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
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
    );
  }

  String _getPreviousScreenName() {
    switch (widget.previousScreen) {
      case 'parts':
        return 'Parts';
      case 'categories':
        return 'Categories';
      case 'levels':
        return 'Levels';
      default:
        return 'Previous Screen';
    }
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
    final currentQuestion = questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / questions.length;

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
                  widget.quiz.formattedType,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Question ${_currentQuestionIndex + 1} of ${questions.length}",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

                // Progress Bar
                const SizedBox(height: 8),
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.white24,
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF9E5BFF), Color(0xFF6B00FF)],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Marks
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [Color(0xFF7A3FFF), Color(0xFF9E5BFF)],
              ),
            ),
            child: Text(
              "${currentQuestion.questionMarks} Marks",
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

  Widget _buildQuestionCard() {
    final question = questions[_currentQuestionIndex];
    final userAnswer = _userAnswers[_currentQuestionIndex];

    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Number and Type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFF141936),
                  ),
                  child: Text(
                    "Q${question.questionNumber}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: _getQuestionTypeColor(question.questionType),
                  ),
                  child: Text(
                    question.questionType.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Question Image if available
            if (question.hasImage) ...[
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF141936),
                  image: const DecorationImage(
                    image: AssetImage('assets/skull_placeholder.png'), // Replace with actual image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Question Text
            Text(
              question.question,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 20),

            // Answer Input based on question type
            if (question.isMCQ) _buildMCQOptions(question, userAnswer),
            if (!question.isMCQ) _buildTextInput(question, userAnswer),
          ],
        ),
      ),
    );
  }

  Widget _buildMCQOptions(QuizQuestion question, String? userAnswer) {
    final options = question.options;
    final optionLabels = ['A', 'B', 'C', 'D'];

    return Column(
      children: [
        for (int i = 0; i < options.length; i++) ...[
          GestureDetector(
            onTap: () => _selectAnswer(optionLabels[i]),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: userAnswer == optionLabels[i]
                    ? const Color(0xFF7A3FFF).withOpacity(0.3)
                    : const Color(0xFF141936),
                border: Border.all(
                  color: userAnswer == optionLabels[i]
                      ? const Color(0xFF7A3FFF)
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: userAnswer == optionLabels[i]
                          ? const Color(0xFF7A3FFF)
                          : const Color(0xFF2A2F4D),
                      border: Border.all(
                        color: userAnswer == optionLabels[i]
                            ? const Color(0xFF7A3FFF)
                            : Colors.white30,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        optionLabels[i],
                        style: TextStyle(
                          color: userAnswer == optionLabels[i]
                              ? Colors.white
                              : Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      options[i],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTextInput(QuizQuestion question, String? userAnswer) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF141936),
      ),
      child: TextField(
        onChanged: (value) => _selectAnswer(value),
        controller: TextEditingController(text: userAnswer),
        maxLines: 4,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: _getHintText(question.questionType),
          hintStyle: const TextStyle(color: Colors.white38),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  String _getHintText(String questionType) {
    switch (questionType.toLowerCase()) {
      case 'identification':
        return 'Enter the name of the anatomical part...';
      case 'practical':
        return 'Describe your answer in detail...';
      default:
        return 'Type your answer here...';
    }
  }

  Color _getQuestionTypeColor(String questionType) {
    switch (questionType.toLowerCase()) {
      case 'mcq':
        return const Color(0xFF7A3FFF);
      case 'identification':
        return const Color(0xFF00D4FF);
      case 'practical':
        return const Color(0xFFFF6B8B);
      default:
        return const Color(0xFF9E5BFF);
    }
  }

  Widget _buildNavigationButtons() {
    final isLastQuestion = _currentQuestionIndex == questions.length - 1;
    final hasAnswer = _userAnswers[_currentQuestionIndex] != null;

    return Row(
      children: [
        // Previous Button
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: const Color(0xFF7A3FFF)),
              color: Colors.transparent,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: _currentQuestionIndex > 0 ? _previousQuestion : null,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.arrow_back, color: Color(0xFF7A3FFF), size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Previous',
                        style: TextStyle(
                          color: Color(0xFF7A3FFF),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 16),

        // Next/Submit Button
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: hasAnswer
                    ? const [Color(0xFF7A3FFF), Color(0xFF9E5BFF)]
                    : [const Color(0xFF7A3FFF).withOpacity(0.3), const Color(0xFF9E5BFF).withOpacity(0.3)],
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: hasAnswer ? (isLastQuestion ? _submitQuiz : _nextQuestion) : null,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isLastQuestion ? 'Submit Quiz' : 'Next',
                        style: TextStyle(
                          color: hasAnswer ? Colors.white : Colors.white54,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (!isLastQuestion) ...[
                        const SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          color: hasAnswer ? Colors.white : Colors.white54,
                          size: 20,
                        ),
                      ],
                    ],
                  ),
                ),
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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Header
                  _buildHeader(),

                  // Question Card
                  Expanded(
                    child: SingleChildScrollView(
                      child: _buildQuestionCard(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Navigation Buttons
                  _buildNavigationButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}