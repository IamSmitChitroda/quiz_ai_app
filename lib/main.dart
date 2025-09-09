import 'package:flutter/material.dart';
import 'features/question_answer/presentation/question_answer_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Study Buddy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AI Study Buddy'),
          backgroundColor: Colors.blue,
        ),
        body: const QuestionAnswerScreen(),
      ),
    );
  }
}
