import 'package:dio/dio.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/favorite/favorite.dart';

abstract class FavoriteApiSource {
  Future<bool> checkProductFavorite(String id);

  Future<bool> actionFavorite(String id);

  Future<PaginationData<FavoriteModel>> getFavorites({
    required int page,
    required int limit,
  });
}

class FavoriteApiSourceImpl implements FavoriteApiSource {
  FavoriteApiSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<bool> checkProductFavorite(String id) async {
    try {
      final response = await dio.get(
        '/favorite/check',
        queryParameters: {'product_id': id},
      );

      return response.data['data'];
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<bool> actionFavorite(String id) async {
    try {
      final response = await dio.post('/favorite', data: {'product_id': id});

      return response.data['data'];
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<PaginationData<FavoriteModel>> getFavorites({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dio.get(
        '/favorite',
        queryParameters: {'page': page, 'limit': limit},
      );

      return PaginationData<FavoriteModel>.fromJson(
        response.data['data'],
        (json) => FavoriteModel.fromJson(json),
      );
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }
}
