import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/config/api_config.dart';
import '../models/quiz.dart';
import '../models/quiz_question.dart';

class QuizRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Quiz> generateQuiz({
    required String topic,
    required String level,
    required String locale,
  }) async {
    final prompt = _buildQuizPrompt(topic, level, locale);

    try {
      final response = await http.post(
        Uri.parse(ApiConfig.groqBaseUrl),
        headers: ApiConfig.headers,
        body: jsonEncode({
          'model': ApiConfig.defaultModel,
          'messages': [
            {
              'role': 'system',
              'content': 'You are a quiz generator assistant.'
            },
            {'role': 'user', 'content': prompt}
          ],
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to generate quiz: ${response.body}');
      }

      final jsonResponse = jsonDecode(response.body);
      final messageContent = jsonResponse['choices'][0]['message']['content'];

      // The content is a string containing JSON, so we need to parse it
      final quizData = jsonDecode(messageContent) as Map<String, dynamic>;

      // Extract questions from the response
      final questions = (quizData['questions'] as List)
          .map((q) => QuizQuestion(
                stem: q['stem'] as String,
                options: List<String>.from(q['options'] as List),
                correctOptionIndex: q['correctOptionIndex'] as int,
                explanation: q['explanation'] as String,
              ))
          .toList();

      final quiz = Quiz(
        topic: topic,
        level: level,
        locale: locale,
        questions: questions,
        createdAt: DateTime.now(),
      );

      // Log quiz generation (non-blocking)
      _logQuizGeneration(quiz).catchError((e) {
        print('Failed to log quiz generation: $e');
      });

      return quiz;
    } catch (e) {
      throw Exception('Failed to generate quiz: $e');
    }
  }

  Future<void> _logQuizGeneration(Quiz quiz) async {
    try {
      await _firestore.collection('quizLogs').add({
        'event': 'quiz_generated',
        'topic': quiz.topic,
        'level': quiz.level,
        'locale': quiz.locale,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // Non-blocking logging - just print the error
      print('Failed to log quiz generation: $e');
    }
  }

  Future<void> logQuizCompletion(Quiz quiz) async {
    try {
      await _firestore.collection('quizLogs').add({
        'event': 'quiz_completed',
        'topic': quiz.topic,
        'level': quiz.level,
        'locale': quiz.locale,
        'score': quiz.score,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // Non-blocking logging - just print the error
      print('Failed to log quiz completion: $e');
    }
  }

  String _buildQuizPrompt(String topic, String level, String locale) {
    return '''
    Generate a multiple choice quiz about $topic in $locale language with difficulty level: $level.
    Requirements:
    - Exactly 5 questions
    - Each question must have:
      * A clear stem/question text
      * Exactly 4 options (A, B, C, D)
      * One correct answer
      * A brief explanation (max 60 words)
    - Questions should be distinct
    - All options should be plausible
    - Return in JSON format with structure:
    {
      "questions": [
        {
          "stem": "question text",
          "options": ["A", "B", "C", "D"],
          "correctOptionIndex": 0-3,
          "explanation": "why this is correct"
        }
      ]
    }
    ''';
  }
}
