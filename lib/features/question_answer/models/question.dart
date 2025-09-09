class Question {
  final String question;
  final String answer;
  final DateTime timestamp;

  Question({
    required this.question,
    required this.answer,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'] as String,
      answer: json['answer'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}
