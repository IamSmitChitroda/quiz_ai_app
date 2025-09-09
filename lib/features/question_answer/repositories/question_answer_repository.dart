import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/config/api_config.dart';
import '../models/question.dart';

class QuestionAnswerRepository {
  final http.Client _client;
  final String _baseUrl;

  QuestionAnswerRepository()
      : _client = http.Client(),
        _baseUrl = ApiConfig.groqBaseUrl;

  Future<String> getAnswer(String question) async {
    try {
      final response = await _client.post(
        Uri.parse(_baseUrl),
        headers: ApiConfig.headers,
        body: jsonEncode({
          'model': ApiConfig.defaultModel,
          "reasoning_effort": "high",
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are a friendly and patient tutor. Explain concepts clearly and avoid technical jargon unless necessary. Keep answers concise but informative.',
            },
            {
              'role': 'user',
              'content': question,
            },
          ],
          'temperature': 0.7,
          'max_tokens': 1000,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final answer = data['choices'][0]['message']['content'] as String;
        return answer.trim();
      } else {
        throw http.ClientException(
          'Failed to get answer. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error getting answer: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}
