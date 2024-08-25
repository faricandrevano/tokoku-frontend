part of 'room_bloc.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();

  @override
  List<Object> get props => [];
}

class GetRoomsEvent extends RoomEvent {
  final int page;

  const GetRoomsEvent(this.page);

  @override
  List<Object> get props => [page];
}
