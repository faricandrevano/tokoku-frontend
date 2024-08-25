part of 'transaction_bloc.dart';

enum TransactionStateStatus { initial, loading, isInfinite, success, failure }

class TransactionState extends Equatable {
  const TransactionState({
    this.status = TransactionStateStatus.initial,
    this.failure,
    this.page = 0,
    this.totalPage = 0,
    this.transactions = const [],
  });

  factory TransactionState.initial() {
    return const TransactionState();
  }

  final TransactionStateStatus status;
  final Failure? failure;
  final List<Transaction> transactions;
  final int page;
  final int totalPage;

  TransactionState copyWith({
    TransactionStateStatus? status,
    Failure? failure,
    List<Transaction>? transactions,
    int? page,
    int? totalPage,
  }) {
    return TransactionState(
      failure: failure ?? this.failure,
      page: page ?? this.page,
      status: status ?? this.status,
      totalPage: totalPage ?? this.totalPage,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object?> get props => [status, failure, transactions, page, totalPage];
}
