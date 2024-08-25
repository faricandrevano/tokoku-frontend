part of 'create_room_bloc.dart';

enum CreateRoomStateStatus { initial, loading, success, failure }

class CreateRoomState extends Equatable {
  const CreateRoomState({
    this.failure,
    this.status = CreateRoomStateStatus.initial,
    this.room,
    this.product,
  });

  factory CreateRoomState.initial() {
    return const CreateRoomState();
  }

  final CreateRoomStateStatus status;
  final Room? room;
  final Product? product;
  final Failure? failure;

  CreateRoomState copyWith({
    CreateRoomStateStatus? status,
    Failure? failure,
    Room? room,
    Product? product,
  }) {
    return CreateRoomState(
      failure: failure ?? this.failure,
      status: status ?? this.status,
      room: room ?? this.room,
      product: product,
    );
  }

  @override
  List<Object?> get props => [status, failure, room, product];
}
