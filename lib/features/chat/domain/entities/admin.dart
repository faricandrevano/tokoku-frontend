import 'package:equatable/equatable.dart';

class Admin extends Equatable {
  final String id;
  final String name;
  final String email;
  final String username;
  final String? phone;
  final String? image;

  const Admin({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    this.phone,
    this.image,
  });

  @override
  List<Object?> get props => [id, name, email, username, phone, image];
}
