import 'package:dartz/dartz.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/cart/cart.dart';

abstract class CartRepository {
  Future<Either<Failure, bool>> addCart({
    required String productId,
    required int qty,
  });

  Future<Either<Failure, List<Cart>>> getCart();

  Future<Either<Failure, bool>> deleteCart(String id);

  Future<Either<Failure, bool>> incrementCart(String id);

  Future<Either<Failure, bool>> decrementCart(String id);
}
