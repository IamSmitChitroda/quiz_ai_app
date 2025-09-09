import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quiz_bloc.dart';
import '../repositories/quiz_repository.dart';
import '../services/quiz_service.dart';
import 'quiz_form.dart';
import 'quiz_runner.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizBloc(
        repository: context.read<QuizRepository>(),
        quizService: context.read<QuizService>(),
      ),
      child: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                state is QuizLoaded || state is QuizCompleted
                    ? 'Quiz: ${(state as dynamic).quiz.topic}'
                    : 'Generate Quiz',
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: state is QuizInitial
                      ? const QuizForm()
                      : const QuizRunner(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
