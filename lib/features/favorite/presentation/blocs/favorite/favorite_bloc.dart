import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shamo_mobile/core/core.dart';
import 'package:shamo_mobile/features/favorite/favorite.dart';
import 'package:shamo_mobile/features/settings/settings.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc({
    required this.getProductFavoritesUseCase,
    required this.actionProductFavoriteUseCase,
  }) : super(FavoriteState.initial()) {
    on<GetFavoriteEvent>(
      (event, emit) async {
        try {
          if (event.page == 1) {
            emit(state.copyWith(status: FavoriteStateStatus.loading));
          } else {
            emit(state.copyWith(status: FavoriteStateStatus.isInfinite));
          }

          final usecase = await getProductFavoritesUseCase(
            GetProductFavoritesParams(
              page: event.page,
              limit: 10,
            ),
          );
          usecase.fold(
            (l) {
              emit(state.copyWith(
                status: FavoriteStateStatus.failure,
                failure: l,
              ));
            },
            (r) {
              emit(state.copyWith(
                status: FavoriteStateStatus.success,
                favorites: event.page == 1 ? r.data : state.favorites + r.data,
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

    on<ActionFavoriteEvent>((event, emit) async {
      try {
        final usecase = await actionProductFavoriteUseCase(event.id);
        usecase.fold(
          (l) {
            emit(state.copyWith(failure: l));
          },
          (r) {
            add(const GetFavoriteEvent(1));
          },
        );
      } catch (exception, stackTrace) {
        exception.recordError(
          RecordErrorParams(exception: exception, stackTrace: stackTrace),
        );
      }
    });
  }

  final GetProductFavoritesUseCase getProductFavoritesUseCase;
  final ActionProductFavoriteUseCase actionProductFavoriteUseCase;
}
