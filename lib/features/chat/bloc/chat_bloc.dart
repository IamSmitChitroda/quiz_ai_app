import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/chat_message.dart';
import '../repositories/chat_repository.dart';

// Events
abstract class ChatEvent {}

class SendMessage extends ChatEvent {
  final String message;
  SendMessage(this.message);
}

class ClearChat extends ChatEvent {}

// States
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final List<ChatMessage> messages;
  ChatSuccess(this.messages);
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}

// Bloc
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository repository;

  ChatBloc({required this.repository}) : super(ChatInitial()) {
    on<SendMessage>(_onSendMessage);
    on<ClearChat>(_onClearChat);
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());

    try {
      await repository.sendMessage(event.message);
      emit(ChatSuccess(repository.messageHistory));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  void _onClearChat(
    ClearChat event,
    Emitter<ChatState> emit,
  ) {
    repository.clearHistory();
    emit(ChatInitial());
  }

  @override
  Future<void> close() {
    repository.dispose();
    return super.close();
  }
}
