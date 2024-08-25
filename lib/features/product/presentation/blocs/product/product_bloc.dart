import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/product/product.dart';
import 'package:shamo_mobile/features/settings/settings.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    required this.getProductsByCategoryUseCase,
    required this.getProductsUseCase,
  }) : super(ProductState.initial()) {
    on<GetPopularProductEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: ProductStateStatus.loading));
        final usecase = await getProductsUseCase(
          const GetProductsParams(isPopular: 1),
        );
        usecase.fold(
          (l) {
            emit(state.copyWith(
              status: ProductStateStatus.failure,
              failure: l,
            ));
          },
          (r) {
            emit(state.copyWith(
              status: ProductStateStatus.success,
              popularProducts: r,
            ));
            add(GetNewProductEvent());
          },
        );
      } catch (exception, stackTrace) {
        exception.recordError(
          RecordErrorParams(exception: exception, stackTrace: stackTrace),
        );
      }
    });

    on<GetNewProductEvent>((event, emit) async {
      try {
        final usecase = await getProductsUseCase(
          const GetProductsParams(isNew: 1),
        );
        usecase.fold(
          (l) {
            emit(state.copyWith(
              status: ProductStateStatus.failure,
              failure: l,
            ));
          },
          (r) {
            emit(state.copyWith(
              status: ProductStateStatus.success,
              newProducts: r,
            ));
          },
        );
      } catch (exception, stackTrace) {
        exception.recordError(
          RecordErrorParams(exception: exception, stackTrace: stackTrace),
        );
      }
    });

    on<GetCategoryProductEvent>((event, emit) async {
      try {
        emit(state.copyWith(statusCategory: ProductStateStatus.loading));
        final usecase = await getProductsByCategoryUseCase(
          GetProductsByCategoryParams(
            id: event.id,
            page: 1,
            limit: 20,
          ),
        );
        usecase.fold(
          (l) {
            emit(state.copyWith(
              statusCategory: ProductStateStatus.failure,
              failure: l,
            ));
          },
          (r) {
            emit(state.copyWith(
              statusCategory: ProductStateStatus.success,
              products: r.data,
            ));
          },
        );
      } catch (exception, stackTrace) {
        exception.recordError(
          RecordErrorParams(exception: exception, stackTrace: stackTrace),
        );
      }
    });
  }

  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;
  final GetProductsUseCase getProductsUseCase;
}
