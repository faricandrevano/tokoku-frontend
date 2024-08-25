import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/chat/chat.dart';

class GetRoomsUseCase
    implements UseCaseFuture<Failure, PaginationData<Room>, PaginateParams> {
  GetRoomsUseCase(this.chatRepository);

  final ChatRepository chatRepository;

  @override
  FutureOr<Either<Failure, PaginationData<Room>>> call(
      PaginateParams params) async {
    return chatRepository.getRooms(
      limit: params.limit,
      page: params.page,
    );
  }
}
