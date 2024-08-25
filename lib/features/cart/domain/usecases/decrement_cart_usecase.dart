import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/cart/cart.dart';

class DecrementCartUseCase implements UseCaseFuture<Failure, bool, String> {
  DecrementCartUseCase(this.cartRepository);

  final CartRepository cartRepository;

  @override
  FutureOr<Either<Failure, bool>> call(String params) async {
    return cartRepository.decrementCart(params);
  }
}
