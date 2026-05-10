part of 'complete_urgent_request_cubit.dart';

@freezed
class CompleteUrgentRequestState with _$CompleteUrgentRequestState {
  const factory CompleteUrgentRequestState.idle() = _Idle;

  const factory CompleteUrgentRequestState.loading() = _Loading;

  const factory CompleteUrgentRequestState.loaded() = _Loaded;

  const factory CompleteUrgentRequestState.error({
    required BottomSheetMessageModel message,
  }) = _Error;


  const factory CompleteUrgentRequestState.connectionError() = _ConnectionError;

  const factory CompleteUrgentRequestState.submitLoading() = _SubmitLoading;

  const factory CompleteUrgentRequestState.submitSuccess({
    required CompleteUrgentRequestDataEntity data,
}) = _SubmitSuccess;
}
