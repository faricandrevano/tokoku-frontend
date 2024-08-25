import 'package:dio/dio.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/chat/chat.dart';

abstract class ChatApiSource {
  Future<RoomModel> createRoom(String adminId);

  Future<PaginationData<RoomModel>> getRooms({
    required int page,
    required int limit,
  });

  Future<PaginationData<ChatModel>> getMessages({
    required String roomId,
    required int page,
    required int limit,
  });

  Future<bool> sendMessage({
    required String roomId,
    required String message,
    String? productId,
  });
}

class ChatApiSourceImpl implements ChatApiSource {
  ChatApiSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<RoomModel> createRoom(String adminId) async {
    try {
      final response = await dio.post('/chat', data: {'admin_id': adminId});

      return RoomModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<PaginationData<RoomModel>> getRooms({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dio.get(
        '/chat',
        queryParameters: {'page': page, 'limit': limit},
      );

      return PaginationData<RoomModel>.fromJson(
        response.data['data'],
        (json) => RoomModel.fromJson(json),
      );
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<PaginationData<ChatModel>> getMessages({
    required String roomId,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dio.get(
        '/chat/$roomId',
        queryParameters: {'page': page, 'limit': limit},
      );

      return PaginationData<ChatModel>.fromJson(
        response.data['data'],
        (json) => ChatModel.fromJson(json),
      );
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<bool> sendMessage({
    required String roomId,
    required String message,
    String? productId,
  }) async {
    try {
      final response = await dio.post('/chat/$roomId', data: {
        'message': message,
        'product_id': productId,
      });

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }
}
