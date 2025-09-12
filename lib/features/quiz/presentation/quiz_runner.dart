import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quiz_bloc.dart';
import 'question_card.dart';
import 'results_summary.dart';

class QuizRunner extends StatelessWidget {
  const QuizRunner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        if (state is QuizLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is QuizError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.message}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        if (state is QuizLoaded) {
          final quiz = state.quiz;
          final currentQuestion = quiz.questions[state.currentQuestionIndex];

          return Column(
            children: [
              LinearProgressIndicator(
                value: (state.currentQuestionIndex + 1) / quiz.questions.length,
                backgroundColor: Colors.grey[200],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Question ${state.currentQuestionIndex + 1}/${quiz.questions.length}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: QuestionCard(
                    question: currentQuestion,
                    onAnswerSelected: (answerIndex) {
                      context.read<QuizBloc>().add(
                            AnswerQuestion(
                              questionIndex: state.currentQuestionIndex,
                              answerIndex: answerIndex,
                            ),
                          );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (state.currentQuestionIndex > 0)
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to previous question
                          context.read<QuizBloc>().add(
                                NavigateToQuestion(
                                  state.currentQuestionIndex - 1,
                                ),
                              );
                        },
                        child: const Text('Previous'),
                      )
                    else
                      const SizedBox.shrink(),
                    if (state.currentQuestionIndex < quiz.questions.length - 1)
                      ElevatedButton(
                        onPressed: currentQuestion.isAnswered
                            ? () {
                                // Navigate to next question
                                context.read<QuizBloc>().add(
                                      NavigateToQuestion(
                                        state.currentQuestionIndex + 1,
                                      ),
                                    );
                              }
                            : null,
                        child: const Text('Next'),
                      )
                    else if (quiz.questions.every((q) => q.isAnswered))
                      ElevatedButton(
                        onPressed: () {
                          context.read<QuizBloc>().add(CompleteQuiz());
                        },
                        child: const Text('Finish Quiz'),
                      ),
                  ],
                ),
              ),
            ],
          );
        }

        if (state is QuizCompleted) {
          return ResultsSummary(quiz: state.quiz);
        }

        return const Center(
          child: Text('Something went wrong'),
        );
      },
    );
  }
}
