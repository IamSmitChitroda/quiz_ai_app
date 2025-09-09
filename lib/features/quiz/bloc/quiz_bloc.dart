import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/quiz.dart';
import '../repositories/quiz_repository.dart';
import '../services/quiz_service.dart';

// Events
// Events
sealed class QuizEvent {
  List<Object?> get props => [];
}

class GenerateQuiz extends QuizEvent {
  final String topic;
  final String level;
  final String locale;

  GenerateQuiz({
    required this.topic,
    required this.level,
    required this.locale,
  });

  @override
  List<Object?> get props => [topic, level, locale];
}

class AnswerQuestion extends QuizEvent {
  final int questionIndex;
  final int answerIndex;

  AnswerQuestion({
    required this.questionIndex,
    required this.answerIndex,
  });

  @override
  List<Object?> get props => [questionIndex, answerIndex];
}

class CompleteQuiz extends QuizEvent {}

class NavigateToQuestion extends QuizEvent {
  final int index;

  NavigateToQuestion(this.index);

  @override
  List<Object?> get props => [index];
}

// States
// States
sealed class QuizState {
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizError extends QuizState {
  final String message;

  QuizError(this.message);

  @override
  List<Object?> get props => [message];
}

class QuizLoaded extends QuizState {
  final Quiz quiz;
  final int currentQuestionIndex;

  QuizLoaded({
    required this.quiz,
    this.currentQuestionIndex = 0,
  });

  @override
  List<Object?> get props => [quiz, currentQuestionIndex];

  QuizLoaded copyWith({
    Quiz? quiz,
    int? currentQuestionIndex,
  }) {
    return QuizLoaded(
      quiz: quiz ?? this.quiz,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    );
  }
}

class QuizCompleted extends QuizState {
  final Quiz quiz;

  QuizCompleted(this.quiz);

  @override
  List<Object?> get props => [quiz];
}

// Bloc
class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository _repository;
  final QuizService _quizService;

  QuizBloc({
    required QuizRepository repository,
    required QuizService quizService,
  })  : _repository = repository,
        _quizService = quizService,
        super(QuizInitial()) {
    on<GenerateQuiz>(_onGenerateQuiz);
    on<AnswerQuestion>(_onAnswerQuestion);
    on<CompleteQuiz>(_onCompleteQuiz);
    on<NavigateToQuestion>(_onNavigateToQuestion);
  }

  Future<void> _onGenerateQuiz(
    GenerateQuiz event,
    Emitter<QuizState> emit,
  ) async {
    emit(QuizLoading());
    try {
      final quiz = await _repository.generateQuiz(
        topic: event.topic,
        level: event.level,
        locale: event.locale,
      );
      emit(QuizLoaded(quiz: quiz));
    } catch (e) {
      emit(QuizError(e.toString()));
    }
  }

  void _onAnswerQuestion(
    AnswerQuestion event,
    Emitter<QuizState> emit,
  ) {
    if (state is QuizLoaded) {
      final currentState = state as QuizLoaded;
      final quiz = currentState.quiz;
      final questions = quiz.questions.toList();

      questions[event.questionIndex].selectedAnswer = event.answerIndex;

      final updatedQuiz = Quiz(
        topic: quiz.topic,
        level: quiz.level,
        locale: quiz.locale,
        questions: questions,
        createdAt: quiz.createdAt,
      );

      emit(currentState.copyWith(quiz: updatedQuiz));
    }
  }

  Future<void> _onCompleteQuiz(
    CompleteQuiz event,
    Emitter<QuizState> emit,
  ) async {
    if (state is QuizLoaded) {
      final quiz = (state as QuizLoaded).quiz;

      // Save to local storage
      await _quizService.saveQuizHistory(quiz);

      // Log completion (non-blocking)
      _repository.logQuizCompletion(quiz).catchError((e) {
        print('Failed to log quiz completion: $e');
      });

      emit(QuizCompleted(quiz));
    }
  }

  void _onNavigateToQuestion(
    NavigateToQuestion event,
    Emitter<QuizState> emit,
  ) {
    if (state is QuizLoaded) {
      final currentState = state as QuizLoaded;
      emit(currentState.copyWith(currentQuestionIndex: event.index));
    }
  }
}
