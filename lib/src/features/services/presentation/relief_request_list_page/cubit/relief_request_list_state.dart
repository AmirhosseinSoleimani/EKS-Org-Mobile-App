part of 'relief_request_list_cubit.dart';

@freezed
class ReliefRequestListState with _$ReliefRequestListState {
  const factory ReliefRequestListState.idle() = _Idle;

  const factory ReliefRequestListState.loading() = _Loading;

  const factory ReliefRequestListState.loaded({

  }) = _Loaded;

  const factory ReliefRequestListState.loadingMore({

  }) = _LoadingMore;

  const factory ReliefRequestListState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory ReliefRequestListState.loadingMoreError({

    required String message,
  }) = _LoadingMoreError;

  const factory ReliefRequestListState.connectionError() = _ConnectionError;
}
