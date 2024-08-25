part of 'category_bloc.dart';

enum CategoryStateStatus { initial, loading, success, failure }

class CategoryState extends Equatable {
  const CategoryState({
    this.categories = const [],
    this.failure,
    this.status = CategoryStateStatus.initial,
    this.id = '',
  });

  factory CategoryState.initial() {
    return const CategoryState();
  }

  final CategoryStateStatus status;
  final List<Category> categories;
  final Failure? failure;
  final String id;

  CategoryState copyWith({
    CategoryStateStatus? status,
    List<Category>? categories,
    Failure? failure,
    String? id,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [id, status, failure, categories];
}
