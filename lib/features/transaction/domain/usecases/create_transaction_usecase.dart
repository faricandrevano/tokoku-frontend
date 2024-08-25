import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/transaction/transaction.dart';

class CreateTransactionUseCase
    implements UseCaseFuture<Failure, bool, CreateTransactionParams> {
  CreateTransactionUseCase(this.transactionRepository);

  final TransactionRepository transactionRepository;

  @override
  FutureOr<Either<Failure, bool>> call(
    CreateTransactionParams params,
  ) async {
    return transactionRepository.createTransaction(
      address: params.address,
      total: params.total,
    );
  }
}

class CreateTransactionParams extends Equatable {
  final String address;
  final int total;

  const CreateTransactionParams({required this.address, required this.total});

  @override
  List<Object?> get props => [address, total];
}
