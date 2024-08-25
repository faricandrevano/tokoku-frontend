import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/features/transaction/transaction.dart';

class TransactionModel extends Equatable {
  final String id;
  final String code;
  final String address;
  final int total;
  final String status;
  final List<TransactionProductModel> products;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TransactionModel({
    required this.id,
    required this.code,
    required this.address,
    required this.total,
    required this.status,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
  });

  Transaction toEntity() {
    return Transaction(
      id: id,
      code: code,
      address: address,
      total: total,
      status: status,
      products: products.map((e) => e.toEntity()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'],
        code: json['code'],
        address: json['address'],
        total: int.parse('${json['total']}'),
        status: json['status'],
        products: (json['products'] as List)
            .map((e) => TransactionProductModel.fromJson(e))
            .toList(),
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

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
