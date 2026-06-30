part of 'evaluation_aid_service_request_cubit.dart';

@freezed
class EvaluationAidServiceRequestState with _$EvaluationAidServiceRequestState {
  const factory EvaluationAidServiceRequestState.idle() = _Idle;

  const factory EvaluationAidServiceRequestState.loading() = _Loading;
  const factory EvaluationAidServiceRequestState.getInfoLoading() = _GetInfoLoading;

  const factory EvaluationAidServiceRequestState.loaded() = _Loaded;

  const factory EvaluationAidServiceRequestState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory EvaluationAidServiceRequestState.connectionError() =
      _ConnectionError;

  const factory EvaluationAidServiceRequestState.submitLoading() =
      _SubmitLoading;

  const factory EvaluationAidServiceRequestState.submitSuccess({required String id}) =
      _SubmitSuccess;

  const factory EvaluationAidServiceRequestState.showAddPartAndLaborBottomSheet() =
      _ShowAddPartAndLaborBottomSheet;

  const factory EvaluationAidServiceRequestState.closeBottomSheetAndRefresh() =
      _CloseBottomSheetBeforeRefresh;
}
