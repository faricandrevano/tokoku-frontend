import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/features/chat/chat.dart';
import 'package:shamo_mobile/features/product/product.dart';

class ChatModel extends Equatable {
  const ChatModel({
    required this.id,
    required this.message,
    required this.type,
    this.product,
  });

  final String id;
  final String message;
  final String type;
  final ProductModel? product;

  Chat toEntity() {
    return Chat(
      id: id,
      message: message,
      type: type,
      product: product?.toEntity(),
    );
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json['id'],
        message: json['message'],
        type: json['type'],
        product: json['product'] != null
            ? ProductModel.fromJson(json['product'])
            : null,
      );

  @override
  List<Object?> get props => [id, message, type, product];
}
