part of 'product_bloc.dart';

enum ProductStateStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  const ProductState({
    this.failure,
    this.newProducts = const [],
    this.popularProducts = const [],
    this.products = const [],
    this.status = ProductStateStatus.initial,
    this.statusCategory = ProductStateStatus.initial,
  });

  factory ProductState.initial() {
    return const ProductState();
  }

  final ProductStateStatus status;
  final ProductStateStatus statusCategory;
  final Failure? failure;
  final List<Product> popularProducts;
  final List<Product> newProducts;
  final List<Product> products;

  ProductState copyWith({
    ProductStateStatus? status,
    ProductStateStatus? statusCategory,
    Failure? failure,
    List<Product>? popularProducts,
    List<Product>? newProducts,
    List<Product>? products,
  }) {
    return ProductState(
      failure: failure ?? this.failure,
      newProducts: newProducts ?? this.newProducts,
      popularProducts: popularProducts ?? this.popularProducts,
      products: products ?? this.products,
      status: status ?? this.status,
      statusCategory: statusCategory ?? this.statusCategory,
    );
  }

  @override
  List<Object?> get props => [
        status,
        failure,
        popularProducts,
        newProducts,
        products,
        statusCategory,
      ];
}
