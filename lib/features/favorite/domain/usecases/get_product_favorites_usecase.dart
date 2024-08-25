import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/favorite/favorite.dart';

class GetProductFavoritesUseCase
    implements
        UseCaseFuture<Failure, PaginationData<Favorite>,
            GetProductFavoritesParams> {
  GetProductFavoritesUseCase(this.favoriteRepository);

  final FavoriteRepository favoriteRepository;

  @override
  FutureOr<Either<Failure, PaginationData<Favorite>>> call(
      GetProductFavoritesParams params) async {
    return favoriteRepository.getFavorites(
      limit: params.limit,
      page: params.page,
    );
  }
}

class GetProductFavoritesParams extends Equatable {
  final int page;
  final int limit;

  const GetProductFavoritesParams({
    required this.page,
    required this.limit,
  });

  @override
  List<Object?> get props => [page, limit];
}
