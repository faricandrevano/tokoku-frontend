import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/favorite/favorite.dart';

class CheckProductFavoriteUseCase
    implements UseCaseFuture<Failure, bool, String> {
  CheckProductFavoriteUseCase(this.favoriteRepository);

  final FavoriteRepository favoriteRepository;

  @override
  FutureOr<Either<Failure, bool>> call(String params) async {
    return favoriteRepository.checkProductFavorite(params);
  }
}
