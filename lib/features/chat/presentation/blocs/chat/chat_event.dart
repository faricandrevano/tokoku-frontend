part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class GetChatsEvent extends ChatEvent {
  final int page;
  final String roomId;

  const GetChatsEvent({required this.page, required this.roomId});

  @override
  List<Object> get props => [page, roomId];
}

class SendChatEvent extends ChatEvent {
  final String message;
  final String roomId;
  final String? productId;

  const SendChatEvent({
    required this.message,
    required this.roomId,
    this.productId,
  });

  @override
  List<Object?> get props => [message, productId, roomId];
}
