import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/product/product.dart';
import 'package:shamo_mobile/features/settings/settings.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required this.getCategoriesUseCase})
      : super(CategoryState.initial()) {
    on<GetCategoryEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: CategoryStateStatus.loading));
        final usecase = await getCategoriesUseCase(const NoParams());
        usecase.fold(
          (l) {
            emit(state.copyWith(
              status: CategoryStateStatus.failure,
              failure: l,
            ));
          },
          (r) {
            emit(state.copyWith(
              status: CategoryStateStatus.success,
              categories: r,
            ));
          },
        );
      } catch (exception, stackTrace) {
        exception.recordError(
          RecordErrorParams(exception: exception, stackTrace: stackTrace),
        );
      }
    });

    on<SelectCategoryEvent>((event, emit) {
      emit(state.copyWith(id: event.id));
    });
  }

  final GetCategoriesUseCase getCategoriesUseCase;
}
