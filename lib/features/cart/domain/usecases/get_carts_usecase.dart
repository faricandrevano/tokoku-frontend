import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/cart/cart.dart';

class GetCartsUseCase implements UseCaseFuture<Failure, List<Cart>, NoParams> {
  GetCartsUseCase(this.cartRepository);

  final CartRepository cartRepository;

  @override
  FutureOr<Either<Failure, List<Cart>>> call(NoParams params) async {
    return cartRepository.getCart();
  }
}
