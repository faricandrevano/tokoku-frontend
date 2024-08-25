import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/transaction/transaction.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc({required this.createTransactionUseCase})
      : super(CheckoutInitial()) {
    on<CreateCheckoutEvent>((event, emit) async {
      emit(CheckoutLoading());
      final usecase = await createTransactionUseCase(CreateTransactionParams(
        address: event.address,
        total: event.total,
      ));
      usecase.fold(
        (l) {
          emit(CheckoutFailure(l));
        },
        (r) {
          emit(CheckoutSuccess());
        },
      );
    });
  }

  final CreateTransactionUseCase createTransactionUseCase;
}
