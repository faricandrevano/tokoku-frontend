import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/chat/chat.dart';

class GetMessagesUseCase
    implements UseCaseFuture<Failure, PaginationData<Chat>, GetMessagesParams> {
  GetMessagesUseCase(this.chatRepository);

  final ChatRepository chatRepository;

  @override
  FutureOr<Either<Failure, PaginationData<Chat>>> call(
      GetMessagesParams params) async {
    return chatRepository.getMessages(
      roomId: params.roomId,
      limit: params.limit,
      page: params.page,
    );
  }
}

class GetMessagesParams extends Equatable {
  final String roomId;
  final int page;
  final int limit;

  const GetMessagesParams({
    required this.roomId,
    required this.page,
    required this.limit,
  });

  @override
  List<Object?> get props => [roomId, page, limit];
}
