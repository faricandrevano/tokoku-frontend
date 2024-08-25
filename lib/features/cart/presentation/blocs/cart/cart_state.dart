part of 'cart_bloc.dart';

enum CartStateStatus { initial, loading, success, failure }

class CartState extends Equatable {
  const CartState({
    this.status = CartStateStatus.initial,
    this.failure,
    this.carts = const [],
  });

  factory CartState.initial() {
    return const CartState();
  }

  final CartStateStatus status;
  final Failure? failure;
  final List<Cart> carts;

  int get total {
    var price = 0;
    for (var element in carts) {
      price += element.qty * element.product.price;
    }
    return price;
  }

  CartState copyWith({
    CartStateStatus? status,
    Failure? failure,
    List<Cart>? carts,
  }) {
    return CartState(
      status: status ?? this.status,
      failure: failure,
      carts: carts ?? this.carts,
    );
  }

  @override
  List<Object?> get props => [failure, status, carts];
}
