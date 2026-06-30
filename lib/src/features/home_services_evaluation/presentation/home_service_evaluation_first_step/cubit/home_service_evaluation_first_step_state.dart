import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/dialog_widget/dialog_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_service_evaluation_first_step_state.freezed.dart';

@freezed
class HomeServiceEvaluationFirstStepState
    with _$HomeServiceEvaluationFirstStepState {
  //common Finalizing Invoice states
  const factory HomeServiceEvaluationFirstStepState.idle() =
      HomeServiceEvaluationFirstStepIdleState;

  const factory HomeServiceEvaluationFirstStepState.loading() =
      HomeServiceEvaluationFirstStepLoadingState;

  const factory HomeServiceEvaluationFirstStepState.success() =
      HomeServiceEvaluationFirstStepSuccessState;

  const factory HomeServiceEvaluationFirstStepState.error({
    required BottomSheetMessageModel message,
  }) = HomeServiceEvaluationFirstStepErrorState;

  const factory HomeServiceEvaluationFirstStepState.submitLoading() =
      HomeServiceEvaluationFirstStepSubmitLoadingState;

  const factory HomeServiceEvaluationFirstStepState.submitSuccess() =
      HomeServiceEvaluationFirstStepSubmitSuccessState;

  const factory HomeServiceEvaluationFirstStepState.submitError({
    required BottomSheetMessageModel message,
  }) = HomeServiceEvaluationFirstStepSubmitErrorState;
}
