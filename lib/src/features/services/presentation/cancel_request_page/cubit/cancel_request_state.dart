part of 'cancel_request_cubit.dart';

@freezed
class CancelRequestState with _$CancelRequestState {
  const factory CancelRequestState.idle() = _Idle;

  const factory CancelRequestState.loading() = _Loading;

  const factory CancelRequestState.loaded() = _Loaded;

  const factory CancelRequestState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory CancelRequestState.loadingMore() = _LoadingMore;


  const factory CancelRequestState.connectionError() = _ConnectionError;
}
