import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/features/chat/chat.dart';

class AdminModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String username;
  final String? phone;
  final String? image;

  const AdminModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    this.phone,
    this.image,
  });

  Admin toEntity() {
    return Admin(
      id: id,
      name: name,
      email: email,
      username: username,
      phone: phone,
      image: image,
    );
  }

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        username: json['username'],
        phone: json['phone'],
        image: json['image'],
      );

  @override
  List<Object?> get props => [id, name, email, username, phone, image];
}
