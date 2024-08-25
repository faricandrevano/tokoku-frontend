part of 'detail_product_bloc.dart';

enum DetailProductStateStatus { initial, loading, success, failure }

class DetailProductState extends Equatable {
  const DetailProductState({
    this.failure,
    this.product,
    this.status = DetailProductStateStatus.initial,
    this.index = 0,
    this.isFavorite = false,
  });

  factory DetailProductState.initial() {
    return const DetailProductState();
  }

  final DetailProductStateStatus status;
  final Product? product;
  final Failure? failure;
  final int index;
  final bool isFavorite;

  DetailProductState copyWith({
    DetailProductStateStatus? status,
    Product? product,
    Failure? failure,
    int? index,
    bool? isFavorite,
  }) {
    return DetailProductState(
      failure: failure ?? this.failure,
      product: product ?? this.product,
      status: status ?? this.status,
      index: index ?? this.index,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [status, failure, product, index, isFavorite];
}
