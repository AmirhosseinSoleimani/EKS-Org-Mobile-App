part of 'cartable_cycle_cubit.dart';

@freezed
class CartableCycleState with _$CartableCycleState {
  const factory CartableCycleState.idle() = _Idle;

  const factory CartableCycleState.loading() = _Loading;

  const factory CartableCycleState.loaded() = _Loaded;

  const factory CartableCycleState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory CartableCycleState.loadingMore() = _LoadingMore;


  const factory CartableCycleState.connectionError() = _ConnectionError;
}
