import 'package:flutter/material.dart';

class QuizScore {
  final String topic;
  final int score;
  final String grade;
  final String timeAgo;

  QuizScore(this.topic, this.score, this.grade, this.timeAgo);

  Color get gradeColor {
    switch (grade) {
      case "A+":
        return const Color(0xFF00FF88);
      case "A":
        return const Color(0xFF00D4FF);
      case "B":
        return const Color(0xFFFFA500);
      default:
        return const Color(0xFFFF4757);
    }
  }
}