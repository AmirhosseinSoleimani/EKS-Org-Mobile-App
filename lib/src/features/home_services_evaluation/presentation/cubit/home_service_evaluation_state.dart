import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/cubit/home_service_evaluation_data.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/cubit/home_service_evaluation_sheet_type.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_service_evaluation_state.freezed.dart';

@freezed
abstract class HomeServiceEvaluationState with _$HomeServiceEvaluationState {
  const HomeServiceEvaluationState._();

  const factory HomeServiceEvaluationState.idle({
    @Default(HomeServiceEvaluationData()) HomeServiceEvaluationData data,
  }) = _Idle;

  const factory HomeServiceEvaluationState.loading({
    required HomeServiceEvaluationData data,
  }) = _Loading;

  const factory HomeServiceEvaluationState.loaded({
    required HomeServiceEvaluationData data,
  }) = _Loaded;

  const factory HomeServiceEvaluationState.failure({
    required HomeServiceEvaluationData data,
    required BottomSheetMessageModel message,
  }) = _Failure;

  const factory HomeServiceEvaluationState.connectionError({
    required HomeServiceEvaluationData data,
  }) = _ConnectionError;

  const factory HomeServiceEvaluationState.submitLoading({
    required HomeServiceEvaluationData data,
  }) = _SubmitLoading;

  const factory HomeServiceEvaluationState.submitSuccess({
    required HomeServiceEvaluationData data,
    required BottomSheetMessageModel message,
  }) = _SubmitSuccess;

  const factory HomeServiceEvaluationState.submitFailure({
    required HomeServiceEvaluationData data,
    required BottomSheetMessageModel message,
  }) = _SubmitFailure;

  const factory HomeServiceEvaluationState.sheetLoading({
    required HomeServiceEvaluationData data,
    required HomeServiceEvaluationSheetType sheetType,
  }) = _SheetLoading;

  const factory HomeServiceEvaluationState.sheetLoaded({
    required HomeServiceEvaluationData data,
    required HomeServiceEvaluationSheetType sheetType,
  }) = _SheetLoaded;

  const factory HomeServiceEvaluationState.sheetFailure({
    required HomeServiceEvaluationData data,
    required HomeServiceEvaluationSheetType sheetType,
    required BottomSheetMessageModel message,
  }) = _SheetFailure;
}