import 'package:dartz/dartz.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/chat/chat.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this.chatApiSource);

  final ChatApiSource chatApiSource;

  @override
  Future<Either<Failure, Room>> createRoom(String adminId) async {
    try {
      final result = await chatApiSource.createRoom(adminId);

      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, PaginationData<Room>>> getRooms({
    required int page,
    required int limit,
  }) async {
    try {
      final result = await chatApiSource.getRooms(
        limit: limit,
        page: page,
      );

      final entity = PaginationData<Room>(
        lastPage: result.lastPage,
        currentPage: result.currentPage,
        data: result.data.map((e) => e.toEntity()).toList(),
      );

      return Right(entity);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, PaginationData<Chat>>> getMessages({
    required String roomId,
    required int page,
    required int limit,
  }) async {
    try {
      final result = await chatApiSource.getMessages(
        roomId: roomId,
        limit: limit,
        page: page,
      );

      final entity = PaginationData<Chat>(
        lastPage: result.lastPage,
        currentPage: result.currentPage,
        data: result.data.map((e) => e.toEntity()).toList(),
      );

      return Right(entity);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, bool>> sendMessage({
    required String roomId,
    required String message,
    String? productId,
  }) async {
    try {
      final result = await chatApiSource.sendMessage(
        message: message,
        roomId: roomId,
        productId: productId,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }
}
