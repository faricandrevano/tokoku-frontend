import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/features/product/product.dart';

class Favorite extends Equatable {
  final String id;
  final ProductModel product;

  const Favorite({
    required this.id,
    required this.product,
  });

  @override
  List<Object?> get props => [id, product];
}
