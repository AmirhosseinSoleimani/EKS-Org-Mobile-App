part of 'follow_up_register_cubit.dart';

@freezed
class FollowUpRegisterState with _$FollowUpRegisterState {
  const factory FollowUpRegisterState.idle() = _Idle;

  const factory FollowUpRegisterState.loading() = _Loading;

  const factory FollowUpRegisterState.loaded() = _Loaded;

  const factory FollowUpRegisterState.error({
    required BottomSheetMessageModel message,
  }) = _Error;


  const factory FollowUpRegisterState.connectionError() = _ConnectionError;

  const factory FollowUpRegisterState.submitLoading() = _SubmitLoading;

  const factory FollowUpRegisterState.submitSuccess({
    required PostFollowUpResponseEntity data,
  }) = _SubmitSuccess;

  const factory FollowUpRegisterState.refreshingHistory() = _RefreshingHistory;

  const factory FollowUpRegisterState.loadingMore() = _LoadingMore;
}
