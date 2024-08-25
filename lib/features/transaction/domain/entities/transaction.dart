import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/features/transaction/transaction.dart';

class Transaction extends Equatable {
  final String id;
  final String code;
  final String address;
  final int total;
  final String status;
  final List<TransactionProduct> products;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Transaction({
    required this.id,
    required this.code,
    required this.address,
    required this.total,
    required this.status,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props => [
        id,
        code,
        address,
        total,
        status,
        products,
        createdAt,
        updatedAt,
      ];
}
