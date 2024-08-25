import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/features/chat/chat.dart';

class Room extends Equatable {
  final String id;
  final String userId;
  final String adminId;
  final DateTime createdAt;
  final DateTime updateAt;
  final Admin admin;

  const Room({
    required this.id,
    required this.userId,
    required this.adminId,
    required this.createdAt,
    required this.updateAt,
    required this.admin,
  });

  @override
  List<Object?> get props => [id, userId, adminId, createdAt, updateAt, admin];
}
