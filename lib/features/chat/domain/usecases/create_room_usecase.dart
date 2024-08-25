import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/chat/chat.dart';

class CreateRoomUseCase implements UseCaseFuture<Failure, Room, String> {
  CreateRoomUseCase(this.chatRepository);

  final ChatRepository chatRepository;

  @override
  FutureOr<Either<Failure, Room>> call(String params) async {
    return chatRepository.createRoom(params);
  }
}
