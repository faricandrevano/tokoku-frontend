part of 'favorite_bloc.dart';

enum FavoriteStateStatus { initial, isInfinite, loading, success, failure }

class FavoriteState extends Equatable {
  const FavoriteState({
    this.failure,
    this.favorites = const [],
    this.page = 0,
    this.status = FavoriteStateStatus.initial,
    this.totalPage = 0,
  });

  factory FavoriteState.initial() {
    return const FavoriteState();
  }

  final FavoriteStateStatus status;
  final Failure? failure;
  final List<Favorite> favorites;
  final int page;
  final int totalPage;

  FavoriteState copyWith({
    FavoriteStateStatus? status,
    Failure? failure,
    List<Favorite>? favorites,
    int? page,
    int? totalPage,
  }) {
    return FavoriteState(
      failure: failure ?? this.failure,
      favorites: favorites ?? this.favorites,
      page: page ?? this.page,
      status: status ?? this.status,
      totalPage: totalPage ?? this.totalPage,
    );
  }

  @override
  List<Object?> get props => [failure, favorites, page, status, totalPage];
}
