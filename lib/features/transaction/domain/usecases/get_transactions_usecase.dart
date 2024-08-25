import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/transaction/transaction.dart';

class GetTransactionsUseCase
    implements
        UseCaseFuture<Failure, PaginationData<Transaction>,
            GetTransactionsParams> {
  GetTransactionsUseCase(this.transactionRepository);

  final TransactionRepository transactionRepository;

  @override
  FutureOr<Either<Failure, PaginationData<Transaction>>> call(
    GetTransactionsParams params,
  ) async {
    return transactionRepository.getTransactions(
      limit: params.limit,
      page: params.page,
    );
  }
}

class GetTransactionsParams extends Equatable {
  final int page;
  final int limit;

  const GetTransactionsParams({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}
