class Quiz {
  final int quizId;
  final int? categoryId;
  final int? levelId;
  final int? partId;
  final String quizType;
  final int totalMarks;
  final int totalQuestions;
  final int completedQuestions;
  final double score;

  Quiz({
    required this.quizId,
    this.categoryId,
    this.levelId,
    this.partId,
    required this.quizType,
    required this.totalMarks,
    required this.totalQuestions,
    this.completedQuestions = 0,
    this.score = 0,
  });

  double get progress {
    return totalQuestions > 0 ? (completedQuestions / totalQuestions) * 100 : 0;
  }

  String get formattedType {
    return quizType.replaceAll('_', ' ').toUpperCase();
  }
}