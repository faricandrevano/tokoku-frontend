part of 'add_cart_bloc.dart';

abstract class AddCartEvent extends Equatable {
  const AddCartEvent();

  @override
  List<Object> get props => [];
}

class ActionAddCartEvent extends AddCartEvent {
  final String productId;
  final int qty;

  const ActionAddCartEvent({required this.productId, required this.qty});

  @override
  List<Object> get props => [productId, qty];
}
