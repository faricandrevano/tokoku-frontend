import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/chat/chat.dart';
import 'package:shamo_mobile/features/settings/settings.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc({required this.getRoomsUseCase}) : super(RoomState.initial()) {
    on<GetRoomsEvent>((event, emit) async {
      try {
        if (event.page == 1) {
          emit(state.copyWith(
            status: RoomStateStatus.loading,
            rooms: [],
          ));
        } else {
          emit(state.copyWith(status: RoomStateStatus.isInfinite));
        }

        final usecase = await getRoomsUseCase(
          PaginateParams(
            page: event.page,
            limit: 10,
          ),
        );
        usecase.fold(
          (l) {
            emit(state.copyWith(
              status: RoomStateStatus.failure,
              failure: l,
            ));
          },
          (r) {
            emit(state.copyWith(
              status: RoomStateStatus.success,
              rooms: state.rooms + r.data,
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
    });
  }

  final GetRoomsUseCase getRoomsUseCase;
}
