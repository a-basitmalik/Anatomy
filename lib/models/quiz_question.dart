class QuizQuestion {
  final int questionId;
  final String question;
  final String? questionImage;
  final int questionMarks;
  final int questionNumber;
  final String questionType; // MCQ, identification, practical, etc.
  final int quizId;
  final String? correctOption;
  final String? optionA;
  final String? optionB;
  final String? optionC;
  final String? optionD;

  QuizQuestion({
    required this.questionId,
    required this.question,
    this.questionImage,
    required this.questionMarks,
    required this.questionNumber,
    required this.questionType,
    required this.quizId,
    this.correctOption,
    this.optionA,
    this.optionB,
    this.optionC,
    this.optionD,
  });

  bool get isMCQ => questionType.toLowerCase() == 'mcq';
  bool get hasImage => questionImage != null && questionImage!.isNotEmpty;

  List<String> get options {
    final List<String> optionsList = [];
    if (optionA != null && optionA!.isNotEmpty) optionsList.add(optionA!);
    if (optionB != null && optionB!.isNotEmpty) optionsList.add(optionB!);
    if (optionC != null && optionC!.isNotEmpty) optionsList.add(optionC!);
    if (optionD != null && optionD!.isNotEmpty) optionsList.add(optionD!);
    return optionsList;
  }
}