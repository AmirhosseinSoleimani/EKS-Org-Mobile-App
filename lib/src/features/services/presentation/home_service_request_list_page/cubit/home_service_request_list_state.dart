part of 'home_service_request_list_cubit.dart';

@freezed
class HomeServiceRequestListState with _$HomeServiceRequestListState {

  const factory HomeServiceRequestListState.idle() = _Idle;

  const factory HomeServiceRequestListState.loading() = _Loading;

  const factory HomeServiceRequestListState.loadingMore() = _LoadingMore;

  const factory HomeServiceRequestListState.loaded() = _Loaded;

  const factory HomeServiceRequestListState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory HomeServiceRequestListState.loadingMoreError({required String message
  }) = _LoadingMoreError;

  const factory HomeServiceRequestListState.connectionError() = _ConnectionError;
}
