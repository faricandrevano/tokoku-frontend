import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/features/product/product.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String desc;
  final int price;
  final String categoryId;
  final String userId;
  final Category category;
  final List<String> galleries;

  const Product({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.categoryId,
    required this.userId,
    required this.category,
    required this.galleries,
  });

  @override
  List<Object?> get props =>
      [id, name, desc, price, category, categoryId, userId, galleries];
}
