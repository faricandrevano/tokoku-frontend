import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/cart/cart.dart';
import 'package:shamo_mobile/features/settings/settings.dart';

part 'add_cart_event.dart';
part 'add_cart_state.dart';

class AddCartBloc extends Bloc<AddCartEvent, AddCartState> {
  AddCartBloc({required this.addCartUseCase}) : super(AddCartState.initial()) {
    on<ActionAddCartEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: AddCartStateStatus.loading));
        final usecase = await addCartUseCase(
          AddCartParams(productId: event.productId, qty: event.qty),
        );
        usecase.fold(
          (l) {
            emit(state.copyWith(
              failure: l,
              status: AddCartStateStatus.failure,
            ));
          },
          (r) {
            emit(state.copyWith(status: AddCartStateStatus.success));
          },
        );
      } catch (exception, stackTrace) {
        exception.recordError(
          RecordErrorParams(exception: exception, stackTrace: stackTrace),
        );
      }
    });
  }

  final AddCartUseCase addCartUseCase;
}
