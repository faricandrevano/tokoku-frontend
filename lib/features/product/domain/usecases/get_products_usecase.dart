import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/product/product.dart';

class GetProductsUseCase
    implements UseCaseFuture<Failure, List<Product>, GetProductsParams> {
  GetProductsUseCase(this.productRepository);

  final ProductRepository productRepository;

  @override
  FutureOr<Either<Failure, List<Product>>> call(
    GetProductsParams params,
  ) async {
    return productRepository.getProducts(
      isNew: params.isNew,
      isPopular: params.isPopular,
    );
  }
}

class GetProductsParams extends Equatable {
  final int? isNew;
  final int? isPopular;

  const GetProductsParams({this.isNew, this.isPopular});

  @override
  List<Object?> get props => [isNew, isPopular];
}
