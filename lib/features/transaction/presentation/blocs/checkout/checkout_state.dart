part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {}

class CheckoutFailure extends CheckoutState {
  final Failure failure;

  const CheckoutFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
