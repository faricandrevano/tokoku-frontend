import 'package:dartz/dartz.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/product/product.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this.productApiSource);

  final ProductApiSource productApiSource;

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final result = await productApiSource.getCategories();

      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct(String id) async {
    try {
      final result = await productApiSource.getProduct(id);

      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    int? isNew,
    int? isPopular,
  }) async {
    try {
      final result = await productApiSource.getProducts(
        isNew: isNew,
        isPopular: isPopular,
      );

      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, PaginationData<Product>>> getProductsByCategory({
    required String id,
    required int page,
    required int limit,
  }) async {
    try {
      final result = await productApiSource.getProductsByCategory(
        id: id,
        limit: limit,
        page: page,
      );

      final entity = PaginationData<Product>(
        currentPage: result.currentPage,
        lastPage: result.lastPage,
        data: result.data.map((e) => e.toEntity()).toList(),
      );

      return Right(entity);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }
}
