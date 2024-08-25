part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCartsEvent extends CartEvent {
  final bool isLoading;

  const GetCartsEvent({this.isLoading = true});

  @override
  List<Object> get props => [isLoading];
}

class DeleteCartEvent extends CartEvent {
  final String id;

  const DeleteCartEvent(this.id);

  @override
  List<Object> get props => [id];
}

class IncrementCartEvent extends CartEvent {
  final String id;

  const IncrementCartEvent(this.id);

  @override
  List<Object> get props => [id];
}

class DecrementCartEvent extends CartEvent {
  final String id;

  const DecrementCartEvent(this.id);

  @override
  List<Object> get props => [id];
}
