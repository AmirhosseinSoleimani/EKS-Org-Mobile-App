part of 'control_info_cubit.dart';

@freezed
class ControlInfoState with _$ControlInfoState {
  const factory ControlInfoState.idle() = _Idle;

  const factory ControlInfoState.loading() = _Loading;

  const factory ControlInfoState.loaded() = _Loaded;

  const factory ControlInfoState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory ControlInfoState.connectionError() = _ConnectionError;
}
