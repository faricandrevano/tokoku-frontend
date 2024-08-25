import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/features/cart/cart.dart';
import 'package:shamo_mobile/features/product/product.dart';

class CartModel extends Equatable {
  final String id;
  final int qty;
  final ProductModel product;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CartModel({
    required this.id,
    required this.qty,
    required this.product,
    required this.createdAt,
    required this.updatedAt,
  });

  Cart toEntity() {
    return Cart(id: id, qty: qty, product: product);
  }

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json['id'],
        qty: int.parse('${json['qty']}'),
        product: ProductModel.fromJson(json['product']),
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  @override
  List<Object?> get props => [id, qty, product, createdAt, updatedAt];
}
