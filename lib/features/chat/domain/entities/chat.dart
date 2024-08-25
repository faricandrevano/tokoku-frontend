import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/features/product/product.dart';

class Chat extends Equatable {
  const Chat({
    required this.id,
    required this.message,
    required this.type,
    this.product,
  });

  final String id;
  final String message;
  final String type;
  final Product? product;

  @override
  List<Object?> get props => [id, message, type, product];
}
