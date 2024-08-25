import 'package:dartz/dartz.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/transaction/transaction.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRepositoryImpl(this.transactionApiSource);

  final TransactionApiSource transactionApiSource;

  @override
  Future<Either<Failure, bool>> createTransaction({
    required int total,
    required String address,
  }) async {
    try {
      final result = await transactionApiSource.createTransaction(
        address: address,
        total: total,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<Failure, PaginationData<Transaction>>> getTransactions({
    required int page,
    required int limit,
  }) async {
    try {
      final result = await transactionApiSource.getTransactions(
        limit: limit,
        page: page,
      );

      final entity = PaginationData<Transaction>(
        lastPage: result.lastPage,
        currentPage: result.currentPage,
        data: result.data.map((e) => e.toEntity()).toList(),
      );

      return Right(entity);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    }
  }
}
