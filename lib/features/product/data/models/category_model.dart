import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/features/product/product.dart';

class CategoryModel extends Equatable {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  Category toEntity() {
    return Category(id: id, name: name);
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        name: json['name'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  @override
  List<Object> get props => [id, name, createdAt, updatedAt];
}
