part of 'update_request_cubit.dart';

@freezed
class UpdateRequestState with _$UpdateRequestState {
  const factory UpdateRequestState.idle() = _Idle;

  const factory UpdateRequestState.loading() = _Loading;

  const factory UpdateRequestState.loaded() = _Loaded;

  const factory UpdateRequestState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory UpdateRequestState.connectionError() = _ConnectionError;
  const factory UpdateRequestState.submitSuccess() = _SubmitSuccess;
}
