part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetCategoryEvent extends CategoryEvent {}

class SelectCategoryEvent extends CategoryEvent {
  final String id;

  const SelectCategoryEvent(this.id);

  @override
  List<Object> get props => [id];
}
