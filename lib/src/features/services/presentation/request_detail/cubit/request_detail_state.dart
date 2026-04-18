part of 'request_detail_cubit.dart';

@freezed
class RequestDetailState with _$RequestDetailState {
  const factory RequestDetailState.idle() = _Idle;

  const factory RequestDetailState.loading() = _Loading;

  const factory RequestDetailState.loaded() = _Loaded;

  const factory RequestDetailState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory RequestDetailState.connectionError() = _ConnectionError;
}
