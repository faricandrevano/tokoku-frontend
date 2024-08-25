import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/chat/chat.dart';

class SendMessageUseCase
    implements UseCaseFuture<Failure, bool, SendMessageParams> {
  SendMessageUseCase(this.chatRepository);

  final ChatRepository chatRepository;

  @override
  FutureOr<Either<Failure, bool>> call(SendMessageParams params) async {
    return chatRepository.sendMessage(
      roomId: params.roomId,
      message: params.message,
      productId: params.productId,
    );
  }
}

class SendMessageParams extends Equatable {
  final String roomId;
  final String message;
  final String? productId;

  const SendMessageParams({
    required this.roomId,
    required this.message,
    this.productId,
  });

  @override
  List<Object?> get props => [roomId, message, productId];
}
