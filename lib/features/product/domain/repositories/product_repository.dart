import 'package:dartz/dartz.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/product/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts({
    int? isNew,
    int? isPopular,
  });

  Future<Either<Failure, List<Category>>> getCategories();

  Future<Either<Failure, PaginationData<Product>>> getProductsByCategory({
    required String id,
    required int page,
    required int limit,
  });

  Future<Either<Failure, Product>> getProduct(String id);
}
