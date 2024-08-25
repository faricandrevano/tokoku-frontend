import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/features/favorite/favorite.dart';
import 'package:shamo_mobile/features/product/product.dart';

class FavoriteModel extends Equatable {
  final String id;
  final ProductModel product;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FavoriteModel({
    required this.id,
    required this.product,
    required this.createdAt,
    required this.updatedAt,
  });

  Favorite toEntity() {
    return Favorite(id: id, product: product);
  }

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        id: json['id'],
        product: ProductModel.fromJson(json['product']),
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  @override
  List<Object?> get props => [id, product, createdAt, updatedAt];
}
