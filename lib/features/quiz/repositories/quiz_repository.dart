import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/config/api_config.dart';
import '../models/quiz.dart';
import '../models/quiz_question.dart';

class QuizRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final http.Client _client = http.Client();

  void dispose() {
    _client.close();
  }

  String _buildQuizPrompt(String topic, String level, String locale) {
    return '''
    Generate a multiple choice quiz about $topic in $locale language with difficulty level: $level.
    Requirements:
    - Exactly 5 questions
    - Each question must have:
      * A clear stem/question text
      * Exactly 4 options
      * One correct answer
      * A brief explanation (max 60 words)
    - Questions should be distinct
    - All options should be plausible
    - Return in JSON format with structure:
    {
      "questions": [
        {
          "stem": "question text",
          "options": ["option1", "option2", "option3", "option4"],
          "correctOptionIndex": 0-3,
          "explanation": "why this is correct"
        }
      ]
    }
    ''';
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
      print('Failed to log quiz generation: $e');
    }
  }

  Future<Quiz> generateQuiz({
    required String topic,
    required String level,
    required String locale,
  }) async {
    final prompt = _buildQuizPrompt(topic, level, locale);

    try {
      final response = await _client.post(
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

      log(response.body);

      if (response.statusCode != 200) {
        throw Exception('Failed to generate quiz: ${response.body}');
      }

      // First parse the API response
      Map<String, dynamic> jsonResponse;
      try {
        jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e) {
        throw FormatException('Invalid API response format: $e');
      }

      if (!jsonResponse.containsKey('choices') ||
          jsonResponse['choices'].isEmpty ||
          !jsonResponse['choices'][0].containsKey('message') ||
          !jsonResponse['choices'][0]['message'].containsKey('content')) {
        throw FormatException('Invalid API response structure');
      }

      final messageContent =
          jsonResponse['choices'][0]['message']['content'] as String;

      // Clean up the content - remove code block markers if present
      final cleanContent =
          messageContent.replaceAll('```json', '').replaceAll('```', '').trim();

      // Parse the cleaned quiz data
      Map<String, dynamic> quizData;
      try {
        quizData = jsonDecode(cleanContent) as Map<String, dynamic>;
      } catch (e) {
        throw FormatException('Invalid quiz data format: $e');
      }

      if (!quizData.containsKey('questions')) {
        throw FormatException('Quiz data is missing questions array');
      }

      List<QuizQuestion> questions;
      try {
        questions = (quizData['questions'] as List)
            .map((q) => QuizQuestion(
                  stem: q['stem'] as String,
                  options: List<String>.from(q['options'] as List),
                  correctOptionIndex: q['correctOptionIndex'] as int,
                  explanation: q['explanation'] as String,
                ))
            .toList();
      } catch (e) {
        throw FormatException('Invalid question format: $e');
      }

      // Validate question count
      if (questions.length != 5) {
        throw FormatException('Quiz must contain exactly 5 questions');
      }

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
      if (e is FormatException) {
        throw e; // Re-throw format exceptions as is
      }
      throw Exception('Failed to generate quiz: $e');
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
      print('Failed to log quiz completion: $e');
    }
  }
}
