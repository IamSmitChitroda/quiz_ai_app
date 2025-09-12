import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/config/api_config.dart';
import '../models/chat_message.dart';

class ChatRepository {
  final http.Client _client;
  final String _baseUrl;
  final List<ChatMessage> _messageHistory = [];

  ChatRepository()
      : _client = http.Client(),
        _baseUrl = ApiConfig.groqBaseUrl;

  List<ChatMessage> get messageHistory => List.unmodifiable(_messageHistory);

  Future<String> sendMessage(String message) async {
    try {
      // Add user message to history
      final userMessage = ChatMessage(
        content: message,
        role: 'user',
        timestamp: DateTime.now(),
      );
      _messageHistory.add(userMessage);

      // Prepare the conversation history
      final messages = _messageHistory
          .map((msg) => {
                'role': msg.role,
                'content': msg.content,
              })
          .toList();

      // Add system message at the start
      messages.insert(0, {
        'role': 'system',
        'content':
            'You are a helpful, empathetic, and knowledgeable chat assistant. Provide accurate and engaging responses while maintaining a natural conversation flow. Stay focused on the user\'s topic and maintain context throughout the discussion.',
      });

      final response = await _client.post(
        Uri.parse(_baseUrl),
        headers: ApiConfig.headers,
        body: jsonEncode({
          'model': ApiConfig.defaultModel,
          'messages': messages,
          'temperature': 0.7,
          'max_tokens': 2048,
          'top_p': 0.9,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final answer =
            jsonResponse['choices'][0]['message']['content'] as String;

        // Add assistant's response to history
        final assistantMessage = ChatMessage(
          content: answer,
          role: 'assistant',
          timestamp: DateTime.now(),
        );
        _messageHistory.add(assistantMessage);

        return answer;
      } else {
        throw Exception('Failed to get response: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void clearHistory() {
    _messageHistory.clear();
  }

  void dispose() {
    _client.close();
  }
}
