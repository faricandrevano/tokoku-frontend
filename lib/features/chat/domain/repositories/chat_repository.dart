import 'package:dartz/dartz.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/chat/chat.dart';

abstract class ChatRepository {
  Future<Either<Failure, Room>> createRoom(String adminId);

  Future<Either<Failure, PaginationData<Room>>> getRooms({
    required int page,
    required int limit,
  });

  Future<Either<Failure, PaginationData<Chat>>> getMessages({
    required String roomId,
    required int page,
    required int limit,
  });

  Future<Either<Failure, bool>> sendMessage({
    required String roomId,
    required String message,
    String? productId,
  });
}
