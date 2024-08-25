import 'package:dio/dio.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/product/product.dart';

abstract class ProductApiSource {
  Future<List<ProductModel>> getProducts({
    int? isNew,
    int? isPopular,
  });

  Future<List<CategoryModel>> getCategories();

  Future<PaginationData<ProductModel>> getProductsByCategory({
    required String id,
    required int page,
    required int limit,
  });

  Future<ProductModel> getProduct(String id);
}

class ProductApiSourceImpl implements ProductApiSource {
  ProductApiSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dio.get('/category');

      final data = (response.data['data'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();

      return data;
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<ProductModel> getProduct(String id) async {
    try {
      final response = await dio.get('/product/$id');

      return ProductModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getProducts({
    int? isNew,
    int? isPopular,
  }) async {
    try {
      final response = await dio.get('/product', queryParameters: {
        'is_new': isNew,
        'is_popular': isPopular,
      });

      final data = (response.data['data'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      return data;
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<PaginationData<ProductModel>> getProductsByCategory({
    required String id,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dio.get('/category/$id', queryParameters: {
        'page': page,
        'limit': limit,
      });

      return PaginationData<ProductModel>.fromJson(
        response.data['data'],
        (json) => ProductModel.fromJson(json),
      );
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }
}
