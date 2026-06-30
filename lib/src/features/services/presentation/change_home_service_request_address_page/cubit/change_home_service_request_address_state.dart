part of 'change_home_service_request_address_cubit.dart';

@freezed
class ChangeHomeServiceRequestAddressState with _$ChangeHomeServiceRequestAddressState {
  const factory ChangeHomeServiceRequestAddressState.idle() = _Idle;

  const factory ChangeHomeServiceRequestAddressState.loading() = _Loading;

  const factory ChangeHomeServiceRequestAddressState.loaded() = _Loaded;

  const factory ChangeHomeServiceRequestAddressState.error({
    required BottomSheetMessageModel message,
  }) = _Error;


  const factory ChangeHomeServiceRequestAddressState.connectionError() = _ConnectionError;

  const factory ChangeHomeServiceRequestAddressState.submitLoading() = _SubmitLoading;

  const factory ChangeHomeServiceRequestAddressState.submitSuccess({
    required BottomSheetMessageModel message,
  }) = _SubmitSuccess;

}
