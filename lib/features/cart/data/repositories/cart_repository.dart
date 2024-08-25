import 'package:dartz/dartz.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/cart/cart.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl(this.cartApiSource);

  final CartApiSource cartApiSource;

  @override
  Future<Either<Failure, bool>> addCart({
    required String productId,
    required int qty,
  }) async {
    try {
      final result = await cartApiSource.addCart(
        productId: productId,
        qty: qty,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, bool>> decrementCart(String id) async {
    try {
      final result = await cartApiSource.decrementCart(id);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCart(String id) async {
    try {
      final result = await cartApiSource.deleteCart(id);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, List<Cart>>> getCart() async {
    try {
      final result = await cartApiSource.getCart();

      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, bool>> incrementCart(String id) async {
    try {
      final result = await cartApiSource.incrementCart(id);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }
}
