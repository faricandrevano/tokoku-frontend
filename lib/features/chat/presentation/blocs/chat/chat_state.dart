part of 'chat_bloc.dart';

enum ChatStateStatus { initial, loading, isInfinite, success, failure }

class ChatState extends Equatable {
  const ChatState({
    this.chats = const [],
    this.failure,
    this.page = 0,
    this.status = ChatStateStatus.initial,
    this.statusMessage = ChatStateStatus.initial,
    this.totalPage = 0,
  });

  factory ChatState.initial() {
    return const ChatState();
  }

  final ChatStateStatus status;
  final ChatStateStatus statusMessage;
  final Failure? failure;
  final List<Chat> chats;
  final int page;
  final int totalPage;

  ChatState copyWith({
    ChatStateStatus? status,
    ChatStateStatus? statusMessage,
    Failure? failure,
    List<Chat>? chats,
    int? page,
    int? totalPage,
  }) {
    return ChatState(
      chats: chats ?? this.chats,
      failure: failure,
      page: page ?? this.page,
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
      totalPage: totalPage ?? this.totalPage,
    );
  }

  @override
  List<Object?> get props =>
      [status, failure, chats, page, totalPage, statusMessage];
}
