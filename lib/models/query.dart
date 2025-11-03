class Query {
  final int queryId;
  final int partId;
  final String question;
  final String? answer;
  final DateTime askedAt;
  final DateTime? answeredAt;
  final String status; // pending, answered

  Query({
    required this.queryId,
    required this.partId,
    required this.question,
    this.answer,
    required this.askedAt,
    this.answeredAt,
    required this.status,
  });

  bool get isAnswered => status == 'answered';
}