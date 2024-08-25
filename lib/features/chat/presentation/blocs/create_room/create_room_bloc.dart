import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/chat/chat.dart';
import 'package:shamo_mobile/features/product/product.dart';
import 'package:shamo_mobile/features/settings/settings.dart';

part 'create_room_event.dart';
part 'create_room_state.dart';

class CreateRoomBloc extends Bloc<CreateRoomEvent, CreateRoomState> {
  CreateRoomBloc({required this.createRoomUseCase})
      : super(CreateRoomState.initial()) {
    on<ActionCreateRoomEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: CreateRoomStateStatus.loading));
        final usecase = await createRoomUseCase(event.adminId);
        usecase.fold(
          (l) {
            emit(state.copyWith(
              failure: l,
              status: CreateRoomStateStatus.failure,
            ));
          },
          (r) {
            emit(state.copyWith(
              status: CreateRoomStateStatus.success,
              room: r,
              product: event.product,
            ));
          },
        );
      } catch (exception, stackTrace) {
        exception.recordError(
          RecordErrorParams(exception: exception, stackTrace: stackTrace),
        );
      }
    });

    on<DeleteProductRoomEvent>((event, emit) {
      emit(state.copyWith(
        product: null,
        status: CreateRoomStateStatus.initial,
      ));
    });
  }

  final CreateRoomUseCase createRoomUseCase;
}
