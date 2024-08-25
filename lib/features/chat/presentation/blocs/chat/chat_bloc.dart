import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/chat/chat.dart';
import 'package:shamo_mobile/features/settings/settings.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
  }) : super(ChatState.initial()) {
    on<GetChatsEvent>(
      (event, emit) async {
        try {
          if (event.page == 1) {
            emit(state.copyWith(status: ChatStateStatus.loading));
          } else {
            emit(state.copyWith(status: ChatStateStatus.isInfinite));
          }

          final usecase = await getMessagesUseCase(
            GetMessagesParams(
              roomId: event.roomId,
              page: event.page,
              limit: 10,
            ),
          );
          usecase.fold(
            (l) {
              emit(state.copyWith(
                status: ChatStateStatus.failure,
                failure: l,
              ));
            },
            (r) {
              emit(state.copyWith(
                status: ChatStateStatus.success,
                chats: event.page == 1 ? r.data : state.chats + r.data,
                page: r.currentPage,
                totalPage: r.lastPage,
              ));
            },
          );
        } catch (exception, stackTrace) {
          exception.recordError(
            RecordErrorParams(exception: exception, stackTrace: stackTrace),
          );
        }
      },
      transformer: debounce(const Duration(milliseconds: 300)),
    );

    on<SendChatEvent>(
      (event, emit) async {
        try {
          emit(state.copyWith(statusMessage: ChatStateStatus.loading));
          final usecase = await sendMessageUseCase(SendMessageParams(
            roomId: event.roomId,
            message: event.message,
            productId: event.productId,
          ));
          usecase.fold(
            (l) {
              emit(state.copyWith(
                statusMessage: ChatStateStatus.failure,
                failure: l,
              ));
            },
            (r) {
              emit(state.copyWith(statusMessage: ChatStateStatus.success));
              add(GetChatsEvent(page: 1, roomId: event.roomId));
            },
          );
        } catch (exception, stackTrace) {
          exception.recordError(
            RecordErrorParams(exception: exception, stackTrace: stackTrace),
          );
        }
      },
    );
  }

  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
}
