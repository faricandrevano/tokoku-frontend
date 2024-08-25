part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class GetTransactionEvent extends TransactionEvent {
  final int page;

  const GetTransactionEvent(this.page);

  @override
  List<Object> get props => [page];
}
