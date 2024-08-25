import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/settings/settings.dart';
import 'package:shamo_mobile/features/transaction/transaction.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc({required this.getTransactionsUseCase})
      : super(TransactionState.initial()) {
    on<GetTransactionEvent>(
      (event, emit) async {
        try {
          if (event.page == 1) {
            emit(state.copyWith(
              status: TransactionStateStatus.loading,
              transactions: [],
            ));
          } else {
            emit(state.copyWith(status: TransactionStateStatus.isInfinite));
          }

          final usecase = await getTransactionsUseCase(
            GetTransactionsParams(
              page: event.page,
              limit: 10,
            ),
          );
          usecase.fold(
            (l) {
              emit(state.copyWith(
                status: TransactionStateStatus.failure,
                failure: l,
              ));
            },
            (r) {
              emit(state.copyWith(
                status: TransactionStateStatus.success,
                transactions: state.transactions + r.data,
                page: r.currentPage,
                totalPage: r.lastPage,
              ));
            },
          );
        } catch (exception, stackTrace) {
          exception.recordError(
            RecordErrorParams(exception: exception, stackTrace: stackTrace),
          );
        }
      },
      transformer: debounce(const Duration(milliseconds: 300)),
    );
  }

  final GetTransactionsUseCase getTransactionsUseCase;
}
