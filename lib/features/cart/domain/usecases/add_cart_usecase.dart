import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/cart/cart.dart';

class AddCartUseCase implements UseCaseFuture<Failure, bool, AddCartParams> {
  AddCartUseCase(this.cartRepository);

  final CartRepository cartRepository;

  @override
  FutureOr<Either<Failure, bool>> call(AddCartParams params) async {
    return cartRepository.addCart(
      productId: params.productId,
      qty: params.qty,
    );
  }
}

class AddCartParams extends Equatable {
  final String productId;
  final int qty;

  const AddCartParams({required this.productId, required this.qty});

  @override
  List<Object?> get props => [productId, qty];
}
