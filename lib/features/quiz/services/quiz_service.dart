import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quiz.dart';

class QuizService {
  static const String _quizHistoryKey = 'quiz_history';
  final SharedPreferences _prefs;

  QuizService(this._prefs);

  Future<void> saveQuizHistory(Quiz quiz) async {
    try {
      final List<String> existingHistory =
          _prefs.getStringList(_quizHistoryKey) ?? [];
      final quizJson = jsonEncode(quiz.toJson());

      // Add new quiz to the beginning of the list
      existingHistory.insert(0, quizJson);

      // Keep only the last 50 quizzes
      if (existingHistory.length > 50) {
        existingHistory.removeRange(50, existingHistory.length);
      }

      await _prefs.setStringList(_quizHistoryKey, existingHistory);
    } catch (e) {
      print('Failed to save quiz history: $e');
      rethrow;
    }
  }

  List<Quiz> loadQuizHistory() {
    try {
      final List<String> historyJson =
          _prefs.getStringList(_quizHistoryKey) ?? [];
      return historyJson
          .map((json) => Quiz.fromJson(jsonDecode(json)))
          .toList();
    } catch (e) {
      print('Failed to load quiz history: $e');
      return [];
    }
  }

  Future<void> clearQuizHistory() async {
    try {
      await _prefs.remove(_quizHistoryKey);
    } catch (e) {
      print('Failed to clear quiz history: $e');
      rethrow;
    }
  }
}
