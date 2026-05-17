part of 'assign_and_cancel_emdadgar_cubit.dart';

@freezed
class AssignAndCancelEmdadgarState with _$AssignAndCancelEmdadgarState {
  const factory AssignAndCancelEmdadgarState.idle() = _Idle;

  const factory AssignAndCancelEmdadgarState.loading() = _Loading;

  const factory AssignAndCancelEmdadgarState.loaded() = _Loaded;

  const factory AssignAndCancelEmdadgarState.error({
    required BottomSheetMessageModel message,
  }) = _Error;


  const factory AssignAndCancelEmdadgarState.connectionError() = _ConnectionError;

  const factory AssignAndCancelEmdadgarState.submitLoading() = _SubmitLoading;

  const factory AssignAndCancelEmdadgarState.submitSuccess({
    required BottomSheetMessageModel message,
  }) = _SubmitSuccess;

  const factory AssignAndCancelEmdadgarState.initNonCooperationLoading() = _InitNonCooperationLoading;

  const factory AssignAndCancelEmdadgarState.initNonCooperationLoaded() = _InitNonCooperationLoaded;

  const factory AssignAndCancelEmdadgarState.initNonCooperationError({
    required BottomSheetMessageModel message,
  }) = _InitNonCooperationError;

  const factory AssignAndCancelEmdadgarState.submitNonCooperationLoading() = _SubmitNonCooperationLoading;

  const factory AssignAndCancelEmdadgarState.submitNonCooperationSuccess({
    required BottomSheetMessageModel message,
  }) = _SubmitNonCooperationSuccess;


  const factory AssignAndCancelEmdadgarState.submitNonCooperationError({
    required BottomSheetMessageModel message,
  }) = _SubmitNonCooperationError;

  const factory AssignAndCancelEmdadgarState.assignSuccess({
    required ServiceAssignResponseEntity response,
  }) = _AssignSuccess;

  const factory AssignAndCancelEmdadgarState.checkDepotLoading({
    required int emdadgarId,
  }) = _CheckDepotLoading;

  const factory AssignAndCancelEmdadgarState.checkDepotSuccess() =
  _CheckDepotSuccess;

}
