import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/product/product.dart';

class GetProductsByCategoryUseCase
    implements
        UseCaseFuture<Failure, PaginationData<Product>,
            GetProductsByCategoryParams> {
  GetProductsByCategoryUseCase(this.productRepository);

  final ProductRepository productRepository;

  @override
  FutureOr<Either<Failure, PaginationData<Product>>> call(
    GetProductsByCategoryParams params,
  ) async {
    return productRepository.getProductsByCategory(
      id: params.id,
      limit: params.limit,
      page: params.page,
    );
  }
}

class GetProductsByCategoryParams extends Equatable {
  final String id;
  final int page;
  final int limit;

  const GetProductsByCategoryParams({
    required this.id,
    required this.page,
    required this.limit,
  });

  @override
  List<Object?> get props => [id, page, limit];
}
