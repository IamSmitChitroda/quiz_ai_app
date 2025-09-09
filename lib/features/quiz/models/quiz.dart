import 'quiz_question.dart';

class Quiz {
  final String topic;
  final String level;
  final String locale;
  final List<QuizQuestion> questions;
  final DateTime createdAt;

  Quiz({
    required this.topic,
    required this.level,
    required this.locale,
    required this.questions,
    required this.createdAt,
  }) {
    assert(questions.length == 5, 'Quiz must have exactly 5 questions');
    assert(level == 'beginner' || level == 'intermediate', 'Invalid level');
    assert(
        locale == 'en' || locale == 'hi' || locale == 'gu', 'Invalid locale');
  }

  int get score => questions.where((q) => q.isAnswered && q.isCorrect).length;
  bool get isCompleted => questions.every((q) => q.isAnswered);

  Map<String, dynamic> toJson() => {
        'topic': topic,
        'level': level,
        'locale': locale,
        'questions': questions.map((q) => q.toJson()).toList(),
        'createdAt': createdAt.toIso8601String(),
      };

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        topic: json['topic'] as String,
        level: json['level'] as String,
        locale: json['locale'] as String,
        questions: (json['questions'] as List)
            .map((q) => QuizQuestion.fromJson(q as Map<String, dynamic>))
            .toList(),
        createdAt: DateTime.parse(json['createdAt'] as String),
      );
}
