import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/product/product.dart';

class GetProductUseCase implements UseCaseFuture<Failure, Product, String> {
  GetProductUseCase(this.productRepository);

  final ProductRepository productRepository;

  @override
  FutureOr<Either<Failure, Product>> call(String params) async {
    return productRepository.getProduct(params);
  }
}
