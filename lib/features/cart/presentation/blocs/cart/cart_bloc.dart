import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/cart/cart.dart';
import 'package:shamo_mobile/features/settings/settings.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({
    required this.getCartsUseCase,
    required this.decrementCartUseCase,
    required this.deleteCartUseCase,
    required this.incrementCartUseCase,
  }) : super(CartState.initial()) {
    on<GetCartsEvent>((event, emit) async {
      try {
        if (event.isLoading) {
          emit(state.copyWith(status: CartStateStatus.loading));
        }
        final usecase = await getCartsUseCase(const NoParams());
        usecase.fold(
          (l) {
            emit(state.copyWith(
              failure: l,
              status: CartStateStatus.failure,
            ));
          },
          (r) {
            emit(state.copyWith(status: CartStateStatus.success, carts: r));
          },
        );
      } catch (exception, stackTrace) {
        exception.recordError(
          RecordErrorParams(exception: exception, stackTrace: stackTrace),
        );
      }
    });

    on<DeleteCartEvent>((event, emit) async {
      try {
        final usecase = await deleteCartUseCase(event.id);
        usecase.fold(
          (l) {
            emit(state.copyWith(failure: l));
          },
          (r) {
            add(const GetCartsEvent(isLoading: false));
          },
        );
      } catch (exception, stackTrace) {
        exception.recordError(
          RecordErrorParams(exception: exception, stackTrace: stackTrace),
        );
      }
    });

    on<IncrementCartEvent>((event, emit) async {
      try {
        final usecase = await incrementCartUseCase(event.id);
        usecase.fold(
          (l) {
            emit(state.copyWith(failure: l));
          },
          (r) {
            add(const GetCartsEvent(isLoading: false));
          },
        );
      } catch (exception, stackTrace) {
        exception.recordError(
          RecordErrorParams(exception: exception, stackTrace: stackTrace),
        );
      }
    });

    on<DecrementCartEvent>((event, emit) async {
      try {
        final usecase = await decrementCartUseCase(event.id);
        usecase.fold(
          (l) {
            emit(state.copyWith(failure: l));
          },
          (r) {
            add(const GetCartsEvent(isLoading: false));
          },
        );
      } catch (exception, stackTrace) {
        exception.recordError(
          RecordErrorParams(exception: exception, stackTrace: stackTrace),
        );
      }
    });
  }

  final GetCartsUseCase getCartsUseCase;
  final DeleteCartUseCase deleteCartUseCase;
  final IncrementCartUseCase incrementCartUseCase;
  final DecrementCartUseCase decrementCartUseCase;
}
