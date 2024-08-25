import 'package:dartz/dartz.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/transaction/transaction.dart';

abstract class TransactionRepository {
  Future<Either<Failure, bool>> createTransaction({
    required int total,
    required String address,
  });

  Future<Either<Failure, PaginationData<Transaction>>> getTransactions({
    required int page,
    required int limit,
  });
}
