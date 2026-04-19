part of 'non_cooperation_cubit.dart';

@freezed
class NonCooperationState with _$NonCooperationState {
  const factory NonCooperationState.idle() = _Idle;

  const factory NonCooperationState.loading() = _Loading;

  const factory NonCooperationState.loaded() = _Loaded;

  const factory NonCooperationState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory NonCooperationState.loadingMore() = _LoadingMore;


  const factory NonCooperationState.connectionError() = _ConnectionError;
}
