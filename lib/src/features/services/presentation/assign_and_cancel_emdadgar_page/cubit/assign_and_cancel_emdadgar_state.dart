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

}
