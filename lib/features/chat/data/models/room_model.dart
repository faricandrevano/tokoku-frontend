import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/features/chat/chat.dart';

class RoomModel extends Equatable {
  final String id;
  final String userId;
  final String adminId;
  final DateTime createdAt;
  final DateTime updateAt;
  final AdminModel admin;

  const RoomModel({
    required this.id,
    required this.userId,
    required this.adminId,
    required this.createdAt,
    required this.updateAt,
    required this.admin,
  });

  Room toEntity() {
    return Room(
      id: id,
      userId: userId,
      adminId: adminId,
      createdAt: createdAt,
      updateAt: updateAt,
      admin: admin.toEntity(),
    );
  }

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
        id: json['id'],
        userId: json['user_id'],
        adminId: json['admin_id'],
        createdAt: DateTime.parse(json['created_at']),
        updateAt: DateTime.parse(json['updated_at']),
        admin: AdminModel.fromJson(json['admin']),
      );

  @override
  List<Object?> get props => [id, userId, adminId, createdAt, updateAt, admin];
}
