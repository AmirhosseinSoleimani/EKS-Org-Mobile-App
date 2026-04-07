part of 'selected_service_cubit.dart';

@freezed
class SelectedServiceState with _$SelectedServiceState {

  const factory SelectedServiceState.idle() = _Idle;

  const factory SelectedServiceState.loading() = _Loading;

  const factory SelectedServiceState.loaded() = _Loaded;

  const factory SelectedServiceState.error({
    required BottomSheetMessageModel message,
  }) = _Error;


  const factory SelectedServiceState.connectionError() = _ConnectionError;
}
