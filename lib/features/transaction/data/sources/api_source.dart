import 'package:dio/dio.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/transaction/transaction.dart';

abstract class TransactionApiSource {
  Future<bool> createTransaction({
    required int total,
    required String address,
  });

  Future<PaginationData<TransactionModel>> getTransactions({
    required int page,
    required int limit,
  });
}

class TransactionApiSourceImpl implements TransactionApiSource {
  TransactionApiSourceImpl(this.dio);

  final Dio dio;

  @override
  Future<bool> createTransaction({
    required int total,
    required String address,
  }) async {
    try {
      final response = await dio.post('/transaction', data: {
        'total': total,
        'address': address,
      });

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw e.toServerException();
    } catch (e) {
      throw ErrorCodeException(message: e.toString());
    }
  }

  @override
  Future<PaginationData<TransactionModel>> getTransactions({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await dio.get('/transaction', queryParameters: {
        'page': page,
        'limit': limit,
      });

      return PaginationData<TransactionModel>.fromJson(
        response.data['data'],
        (json) => TransactionModel.fromJson(json),
      );
    } on DioException catch (e) {
      throw e.toServerException();
    }
    //  catch (e) {
    //   throw ErrorCodeException(message: e.toString());
    // }
  }
}
