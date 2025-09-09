import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../bloc/question_answer_bloc.dart';
import '../repositories/question_answer_repository.dart';

class QuestionAnswerScreen extends StatelessWidget {
  const QuestionAnswerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionAnswerBloc(
        repository: QuestionAnswerRepository(),
      ),
      child: const QuestionAnswerView(),
    );
  }
}

class QuestionAnswerView extends StatefulWidget {
  const QuestionAnswerView({super.key});

  @override
  State<QuestionAnswerView> createState() => _QuestionAnswerViewState();
}

class _QuestionAnswerViewState extends State<QuestionAnswerView> {
  final _questionController = TextEditingController();

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _questionController,
            decoration: InputDecoration(
              hintText: 'Ask any question...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  if (_questionController.text.isNotEmpty) {
                    context.read<QuestionAnswerBloc>().add(
                          AskQuestion(_questionController.text),
                        );
                    _questionController.clear();
                  }
                },
              ),
            ),
            maxLines: 3,
            minLines: 1,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<QuestionAnswerBloc, QuestionAnswerState>(
              builder: (context, state) {
                if (state is QuestionAnswerLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is QuestionAnswerSuccess) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Q: ${state.question}',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        MarkdownBody(
                          data: state.answer,
                          selectable: true,
                        ),
                      ],
                    ),
                  );
                } else if (state is QuestionAnswerError) {
                  return Center(
                    child: Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                return const Center(
                  child: Text('Ask a question to get started!'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
