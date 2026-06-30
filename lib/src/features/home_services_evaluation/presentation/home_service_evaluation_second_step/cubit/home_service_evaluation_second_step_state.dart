import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_service_evaluation_second_step_state.freezed.dart';

@freezed
class HomeServiceEvaluationSecondStepState
    with _$HomeServiceEvaluationSecondStepState {
  const factory HomeServiceEvaluationSecondStepState.idle() = _Idle;

  const factory HomeServiceEvaluationSecondStepState.loading() = _Loading;

  const factory HomeServiceEvaluationSecondStepState.success() = _Success;

  const factory HomeServiceEvaluationSecondStepState.error({
    required BottomSheetMessageModel message,
  }) = _Error;

  const factory HomeServiceEvaluationSecondStepState.submitLoading() =
  _SubmitLoading;

  const factory HomeServiceEvaluationSecondStepState.submitSuccess() =
  _SubmitSuccess;

  const factory HomeServiceEvaluationSecondStepState.submitError({
    required BottomSheetMessageModel message,
  }) = _SubmitError;

  const factory HomeServiceEvaluationSecondStepState.submitNeedPhotoSuccess() =
  _SubmitNeedPhotoSuccess;

  const factory HomeServiceEvaluationSecondStepState.otherServiceLoading() =
  _OtherServiceLoading;

  const factory HomeServiceEvaluationSecondStepState.otherServiceSuccess() =
  _OtherServiceSuccess;
}