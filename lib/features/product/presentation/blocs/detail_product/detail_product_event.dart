part of 'detail_product_bloc.dart';

abstract class DetailProductEvent extends Equatable {
  const DetailProductEvent();

  @override
  List<Object> get props => [];
}

class GetDetailProductEvent extends DetailProductEvent {
  final String id;

  const GetDetailProductEvent(this.id);

  @override
  List<Object> get props => [id];
}

class CheckFavoriteProductEvent extends DetailProductEvent {
  final String id;

  const CheckFavoriteProductEvent(this.id);

  @override
  List<Object> get props => [id];
}

class ActionFavoriteProductEvent extends DetailProductEvent {
  final String id;

  const ActionFavoriteProductEvent(this.id);

  @override
  List<Object> get props => [id];
}

class ChangeIndexDetailProductEvent extends DetailProductEvent {
  final int index;

  const ChangeIndexDetailProductEvent(this.index);

  @override
  List<Object> get props => [index];
}
