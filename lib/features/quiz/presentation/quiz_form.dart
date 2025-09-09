import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quiz_bloc.dart';

class QuizForm extends StatefulWidget {
  const QuizForm({Key? key}) : super(key: key);

  @override
  State<QuizForm> createState() => _QuizFormState();
}

class _QuizFormState extends State<QuizForm> {
  final _formKey = GlobalKey<FormState>();
  final _topicController = TextEditingController();
  String _selectedLevel = 'beginner';
  String _selectedLocale = 'en';

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<QuizBloc>().add(
            GenerateQuiz(
              topic: _topicController.text,
              level: _selectedLevel,
              locale: _selectedLocale,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _topicController,
            decoration: const InputDecoration(
              labelText: 'Quiz Topic',
              hintText: 'Enter a topic for your quiz',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a topic';
              }
              if (value.length < 3) {
                return 'Topic must be at least 3 characters';
              }
              if (value.length > 120) {
                return 'Topic must be less than 120 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedLevel,
            decoration: const InputDecoration(
              labelText: 'Difficulty Level',
            ),
            items: const [
              DropdownMenuItem(
                value: 'beginner',
                child: Text('Beginner'),
              ),
              DropdownMenuItem(
                value: 'intermediate',
                child: Text('Intermediate'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _selectedLevel = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedLocale,
            decoration: const InputDecoration(
              labelText: 'Language',
            ),
            items: const [
              DropdownMenuItem(
                value: 'en',
                child: Text('English'),
              ),
              DropdownMenuItem(
                value: 'hi',
                child: Text('Hindi'),
              ),
              DropdownMenuItem(
                value: 'gu',
                child: Text('Gujarati'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _selectedLocale = value!;
              });
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _handleSubmit,
            child: const Text('Generate Quiz'),
          ),
        ],
      ),
    );
  }
}
