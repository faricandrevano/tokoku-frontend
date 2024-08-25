import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/product/product.dart';

class GetCategoriesUseCase
    implements UseCaseFuture<Failure, List<Category>, NoParams> {
  GetCategoriesUseCase(this.productRepository);

  final ProductRepository productRepository;

  @override
  FutureOr<Either<Failure, List<Category>>> call(NoParams params) async {
    return productRepository.getCategories();
  }
}
