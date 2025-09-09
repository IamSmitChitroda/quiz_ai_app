import 'package:flutter/foundation.dart';

class QuizQuestion {
  final String stem;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;
  int? selectedAnswer;

  QuizQuestion({
    required this.stem,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
    this.selectedAnswer,
  }) {
    assert(options.length == 4, 'Must have exactly 4 options');
    assert(correctOptionIndex >= 0 && correctOptionIndex < 4,
        'Invalid correct option index');
  }

  bool get isAnswered => selectedAnswer != null;
  bool get isCorrect => selectedAnswer == correctOptionIndex;

  Map<String, dynamic> toJson() => {
        'stem': stem,
        'options': options,
        'correctOptionIndex': correctOptionIndex,
        'explanation': explanation,
        'selectedAnswer': selectedAnswer,
      };

  factory QuizQuestion.fromJson(Map<String, dynamic> json) => QuizQuestion(
        stem: json['stem'] as String,
        options: List<String>.from(json['options'] as List),
        correctOptionIndex: json['correctOptionIndex'] as int,
        explanation: json['explanation'] as String,
        selectedAnswer: json['selectedAnswer'] as int?,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizQuestion &&
          runtimeType == other.runtimeType &&
          stem == other.stem &&
          listEquals(options, other.options) &&
          correctOptionIndex == other.correctOptionIndex;

  @override
  int get hashCode =>
      stem.hashCode ^ options.hashCode ^ correctOptionIndex.hashCode;
}
