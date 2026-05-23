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


  const factory AssignAndCancelEmdadgarState.getReasonListLoading({
    required ServiceAssignAction action
  }) = _GetReasonListLoading;

  const factory AssignAndCancelEmdadgarState.showOperationSuccessMessage({
    required ServiceAssignResponseEntity response,
    required ServiceAssignAction operationAction,
  }) = _AssignSuccess;

  const factory AssignAndCancelEmdadgarState.checkDepotLoading({
    required int emdadgarId,
  }) = _CheckDepotLoading;

  const factory AssignAndCancelEmdadgarState.showEmdadgarInfoBottomSheet() =
  _CheckDepotSuccess;

  const factory AssignAndCancelEmdadgarState.showAssignConfirmBottomSheet() =
  _ShowAssignConfirmBottomSheet;

  const factory AssignAndCancelEmdadgarState.showNonCooperationBottomSheet() =
  _ShowNonCooperationBottomSheet;

  const factory AssignAndCancelEmdadgarState.showCancelMissionBottomSheet() =
  _ShowCancelMissionBottomSheet;

}
