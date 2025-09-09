import 'package:flutter/material.dart';
import '../models/quiz_question.dart';

class QuestionCard extends StatefulWidget {
  final QuizQuestion question;
  final void Function(int) onAnswerSelected;

  const QuestionCard({
    Key? key,
    required this.question,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  bool _showExplanation = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.question.stem,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ...List.generate(
              widget.question.options.length,
              (index) => RadioListTile<int>(
                title: Text(widget.question.options[index]),
                value: index,
                groupValue: widget.question.selectedAnswer,
                onChanged: widget.question.isAnswered
                    ? null
                    : (value) {
                        widget.onAnswerSelected(value!);
                        setState(() {
                          _showExplanation = true;
                        });
                      },
              ),
            ),
            if (_showExplanation && widget.question.isAnswered) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.question.isCorrect
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          widget.question.isCorrect
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: widget.question.isCorrect
                              ? Colors.green
                              : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.question.isCorrect ? 'Correct!' : 'Incorrect',
                          style: TextStyle(
                            color: widget.question.isCorrect
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.question.explanation,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
