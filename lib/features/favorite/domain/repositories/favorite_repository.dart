import 'package:dartz/dartz.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/favorite/favorite.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, bool>> checkProductFavorite(String id);

  Future<Either<Failure, bool>> actionFavorite(String id);

  Future<Either<Failure, PaginationData<Favorite>>> getFavorites({
    required int page,
    required int limit,
  });
}
