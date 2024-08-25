import 'package:dio/dio.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/cart/cart.dart';

abstract class CartApiSource {
  Future<bool> addCart({required String productId, required int qty});

  Future<List<CartModel>> getCart();

  Future<bool> deleteCart(String id);

  Future<bool> incrementCart(String id);

  Future<bool> decrementCart(String id);
}

class CartApiSourceImpl implements CartApiSource {
  CartApiSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<bool> addCart({required String productId, required int qty}) async {
    try {
      final response = await dio.post(
        '/cart',
        data: {'product_id': productId, 'qty': qty},
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<bool> decrementCart(String id) async {
    try {
      final response = await dio.post(
        '/cart/decrement',
        queryParameters: {'cart_id': id},
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<bool> deleteCart(String id) async {
    try {
      final response = await dio.delete(
        '/cart',
        queryParameters: {'cart_id': id},
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<List<CartModel>> getCart() async {
    try {
      final response = await dio.get('/cart');

      final data = (response.data['data'] as List)
          .map((e) => CartModel.fromJson(e))
          .toList();

      return data;
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<bool> incrementCart(String id) async {
    try {
      final response = await dio.post(
        '/cart/increment',
        queryParameters: {'cart_id': id},
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }
}
