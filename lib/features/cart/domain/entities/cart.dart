import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/features/product/product.dart';

class Cart extends Equatable {
  final String id;
  final int qty;
  final ProductModel product;

  const Cart({
    required this.id,
    required this.qty,
    required this.product,
  });

  @override
  List<Object?> get props => [id, qty, product];
}
