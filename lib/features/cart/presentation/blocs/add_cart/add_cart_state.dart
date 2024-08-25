part of 'add_cart_bloc.dart';

enum AddCartStateStatus { initial, loading, success, failure }

class AddCartState extends Equatable {
  const AddCartState({
    this.status = AddCartStateStatus.initial,
    this.failure,
  });

  factory AddCartState.initial() {
    return const AddCartState();
  }

  final AddCartStateStatus status;
  final Failure? failure;

  AddCartState copyWith({
    AddCartStateStatus? status,
    Failure? failure,
  }) {
    return AddCartState(
      failure: failure,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [failure, status];
}
