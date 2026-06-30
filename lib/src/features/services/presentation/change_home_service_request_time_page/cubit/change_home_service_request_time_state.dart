part of 'change_home_service_request_time_cubit.dart';

@freezed
class ChangeHomeServiceRequestTimeState with _$ChangeHomeServiceRequestTimeState {
  const factory ChangeHomeServiceRequestTimeState.idle() = _Idle;

  const factory ChangeHomeServiceRequestTimeState.loading() = _Loading;

  const factory ChangeHomeServiceRequestTimeState.loaded() = _Loaded;

  const factory ChangeHomeServiceRequestTimeState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory ChangeHomeServiceRequestTimeState.daySelected({
    required DayScheduleEntity day,
  }) = _DaySelected;

  const factory ChangeHomeServiceRequestTimeState.timeSelected({
    required TimeRangeEntity time,
  }) = _TimeSelected;

  const factory ChangeHomeServiceRequestTimeState.connectionError() = _ConnectionError;

  const factory ChangeHomeServiceRequestTimeState.submitLoading() = _SubmitLoading;

  const factory ChangeHomeServiceRequestTimeState.submitSuccess({
    required BottomSheetMessageModel message,
  }) = _SubmitSuccess;

}
