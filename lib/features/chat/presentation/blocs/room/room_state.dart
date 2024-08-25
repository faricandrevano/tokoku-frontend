part of 'room_bloc.dart';

enum RoomStateStatus { intial, loading, isInfinite, success, failure }

class RoomState extends Equatable {
  const RoomState({
    this.failure,
    this.page = 0,
    this.rooms = const [],
    this.status = RoomStateStatus.intial,
    this.totalPage = 0,
  });

  factory RoomState.initial() {
    return const RoomState();
  }

  final RoomStateStatus status;
  final Failure? failure;
  final List<Room> rooms;
  final int page;
  final int totalPage;

  RoomState copyWith({
    RoomStateStatus? status,
    Failure? failure,
    List<Room>? rooms,
    int? page,
    int? totalPage,
  }) {
    return RoomState(
      failure: failure,
      page: page ?? this.page,
      rooms: rooms ?? this.rooms,
      status: status ?? this.status,
      totalPage: totalPage ?? this.totalPage,
    );
  }

  @override
  List<Object?> get props => [page, rooms, status, failure, totalPage];
}
