part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetPopularProductEvent extends ProductEvent {}

class GetNewProductEvent extends ProductEvent {}

class GetCategoryProductEvent extends ProductEvent {
  final String id;

  const GetCategoryProductEvent(this.id);

  @override
  List<Object> get props => [id];
}
