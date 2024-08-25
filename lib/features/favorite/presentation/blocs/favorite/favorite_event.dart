part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class GetFavoriteEvent extends FavoriteEvent {
  final int page;

  const GetFavoriteEvent(this.page);

  @override
  List<Object> get props => [page];
}

class ActionFavoriteEvent extends FavoriteEvent {
  final String id;

  const ActionFavoriteEvent(this.id);

  @override
  List<Object> get props => [id];
}
