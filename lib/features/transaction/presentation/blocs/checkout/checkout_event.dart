part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class CreateCheckoutEvent extends CheckoutEvent {
  final String address;
  final int total;

  const CreateCheckoutEvent(this.address, this.total);

  @override
  List<Object> get props => [address, total];
}
