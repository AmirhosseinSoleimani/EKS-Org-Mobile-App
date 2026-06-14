

import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_service_evaluation_second_step_state.freezed.dart';

@freezed
class HomeServiceEvaluationSecondStepState with _$HomeServiceEvaluationSecondStepState {

  //common Finalizing Invoice states
  const factory HomeServiceEvaluationSecondStepState.idle() = HomeServiceEvaluationSecondStepIdleState;
  const factory HomeServiceEvaluationSecondStepState.loading() = HomeServiceEvaluationSecondStepLoadingState;
  const factory HomeServiceEvaluationSecondStepState.success() = HomeServiceEvaluationSecondStepSuccessState;
  const factory HomeServiceEvaluationSecondStepState.otherServiceLoading() = HomeServiceEvaluationSecondStepOtherServiceLoadingState;
  const factory HomeServiceEvaluationSecondStepState.otherServiceSuccess() = HomeServiceEvaluationSecondStepOtherServiceSuccessState;
  const factory HomeServiceEvaluationSecondStepState.error({required DialogDataModel dialogDataModel}) = HomeServiceEvaluationSecondStepErrorState;
  const factory HomeServiceEvaluationSecondStepState.submitLoading() = HomeServiceEvaluationSecondStepSubmitLoadingState;
  const factory HomeServiceEvaluationSecondStepState.submitSuccess() = HomeServiceEvaluationSecondStepSubmitSuccessState;
  const factory HomeServiceEvaluationSecondStepState.submitNeedPhotoSuccess() = HomeServiceEvaluationSecondStepNeedPhotoSuccessState;
  const factory HomeServiceEvaluationSecondStepState.submitError({required DialogDataModel dialogDataModel}) = HomeServiceEvaluationSecondStepSubmitErrorState;
}