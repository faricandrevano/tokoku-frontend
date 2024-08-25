import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/favorite/favorite.dart';
import 'package:shamo_mobile/features/product/product.dart';
import 'package:shamo_mobile/features/settings/settings.dart';

part 'detail_product_event.dart';
part 'detail_product_state.dart';

class DetailProductBloc extends Bloc<DetailProductEvent, DetailProductState> {
  DetailProductBloc({
    required this.getProductUseCase,
    required this.checkProductFavoriteUseCase,
    required this.actionProductFavoriteUseCase,
  }) : super(DetailProductState.initial()) {
    on<GetDetailProductEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: DetailProductStateStatus.loading));
        final usecase = await getProductUseCase(event.id);
        usecase.fold(
          (l) {
            emit(state.copyWith(
              status: DetailProductStateStatus.failure,
              failure: l,
            ));
          },
          (r) {
            emit(state.copyWith(
              status: DetailProductStateStatus.success,
              product: r,
            ));
            add(CheckFavoriteProductEvent(event.id));
          },
        );
      } catch (exception, stackTrace) {
        exception.recordError(
          RecordErrorParams(exception: exception, stackTrace: stackTrace),
        );
      }
    });

    on<CheckFavoriteProductEvent>((event, emit) async {
      try {
        final usecase = await checkProductFavoriteUseCase(event.id);
        usecase.fold(
          (l) {
            emit(state.copyWith(failure: l));
          },
          (r) {
            emit(state.copyWith(isFavorite: r));
          },
        );
      } catch (exception, stackTrace) {
        exception.recordError(
          RecordErrorParams(exception: exception, stackTrace: stackTrace),
        );
      }
    });

    on<ActionFavoriteProductEvent>((event, emit) async {
      try {
        final usecase = await actionProductFavoriteUseCase(event.id);
        usecase.fold(
          (l) {
            emit(state.copyWith(failure: l));
          },
          (r) {
            emit(state.copyWith(isFavorite: r));
          },
        );
      } catch (exception, stackTrace) {
        exception.recordError(
          RecordErrorParams(exception: exception, stackTrace: stackTrace),
        );
      }
    });

    on<ChangeIndexDetailProductEvent>((event, emit) async {
      emit(state.copyWith(index: event.index));
    });
  }

  final GetProductUseCase getProductUseCase;
  final CheckProductFavoriteUseCase checkProductFavoriteUseCase;
  final ActionProductFavoriteUseCase actionProductFavoriteUseCase;
}
