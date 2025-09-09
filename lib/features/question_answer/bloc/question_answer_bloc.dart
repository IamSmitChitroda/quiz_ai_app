import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/question_answer_repository.dart';

// Events
abstract class QuestionAnswerEvent {}

class AskQuestion extends QuestionAnswerEvent {
  final String question;
  AskQuestion(this.question);
}

// States
abstract class QuestionAnswerState {}

class QuestionAnswerInitial extends QuestionAnswerState {}

class QuestionAnswerLoading extends QuestionAnswerState {}

class QuestionAnswerSuccess extends QuestionAnswerState {
  final String question;
  final String answer;
  QuestionAnswerSuccess({required this.question, required this.answer});
}

class QuestionAnswerError extends QuestionAnswerState {
  final String message;
  QuestionAnswerError(this.message);
}

// Bloc
class QuestionAnswerBloc
    extends Bloc<QuestionAnswerEvent, QuestionAnswerState> {
  final QuestionAnswerRepository repository;

  QuestionAnswerBloc({required this.repository})
      : super(QuestionAnswerInitial()) {
    on<AskQuestion>(_onAskQuestion);
  }

  Future<void> _onAskQuestion(
      AskQuestion event, Emitter<QuestionAnswerState> emit) async {
    emit(QuestionAnswerLoading());

    try {
      final answer = await repository.getAnswer(event.question);
      emit(QuestionAnswerSuccess(question: event.question, answer: answer));
    } catch (e) {
      emit(QuestionAnswerError(e.toString()));
    }
  }
}
