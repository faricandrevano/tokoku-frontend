import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/features/product/product.dart';
import 'package:shamo_mobile/features/transaction/transaction.dart';

class TransactionProductModel extends Equatable {
  final String id;
  final int qty;
  final ProductModel product;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TransactionProductModel({
    required this.id,
    required this.qty,
    required this.product,
    required this.createdAt,
    required this.updatedAt,
  });

  TransactionProduct toEntity() {
    return TransactionProduct(id: id, qty: qty, product: product);
  }

  factory TransactionProductModel.fromJson(Map<String, dynamic> json) =>
      TransactionProductModel(
        id: json['id'],
        qty: int.parse('${json['qty']}'),
        product: ProductModel.fromJson(json['product']),
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  @override
  List<Object> get props => [id, qty, product, createdAt, updatedAt];
}
