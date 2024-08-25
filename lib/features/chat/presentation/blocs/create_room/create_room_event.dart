part of 'create_room_bloc.dart';

abstract class CreateRoomEvent extends Equatable {
  const CreateRoomEvent();

  @override
  List<Object?> get props => [];
}

class ActionCreateRoomEvent extends CreateRoomEvent {
  final String adminId;
  final Product? product;

  const ActionCreateRoomEvent({
    required this.adminId,
    this.product,
  });

  @override
  List<Object?> get props => [adminId, product];
}

class DeleteProductRoomEvent extends CreateRoomEvent {}
