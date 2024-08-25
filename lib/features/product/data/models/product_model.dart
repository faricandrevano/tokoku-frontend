import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/features/product/product.dart';

class ProductModel extends Equatable {
  final String id;
  final String name;
  final String desc;
  final int price;
  final String categoryId;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CategoryModel category;
  final List<String> galleries;

  const ProductModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.categoryId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.galleries,
  });

  Product toEntity() {
    return Product(
      id: id,
      name: name,
      desc: desc,
      price: price,
      categoryId: categoryId,
      userId: userId,
      category: category.toEntity(),
      galleries: galleries,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['name'],
        desc: json['desc'],
        price: int.parse('${json['price']}'),
        categoryId: json['category_id'],
        userId: json['user_id'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        category: CategoryModel.fromJson(json['category']),
        galleries: List<String>.from(json['galleries'].map((x) => x['url'])),
      );

  @override
  List<Object?> get props => [
        id,
        name,
        desc,
        price,
        category,
        categoryId,
        userId,
        createdAt,
        updatedAt,
        galleries
      ];
}
