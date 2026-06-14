import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'labors_and_parts_state.freezed.dart';

@freezed
class LaborsAndPartsState with _$LaborsAndPartsState {

  const factory LaborsAndPartsState.idle() = LaborsAndPartsIdleState;
  const factory LaborsAndPartsState.loading() = LaborsAndPartsLoadingState;
  const factory LaborsAndPartsState.success() = LaborsAndPartsSuccessState;
  const factory LaborsAndPartsState.error({required DialogDataModel dialogDataModel}) = LaborsAndPartsErrorState;
  const factory LaborsAndPartsState.notice({required DialogDataModel dialogDataModel}) = LaborsAndPartsNoticeState;
  const factory LaborsAndPartsState.partPriceLoading() = LaborsAndPartsPartPriceLoadingState;
  const factory LaborsAndPartsState.partPriceSuccess() = LaborsAndPartsPartPriceSuccessState;
  const factory LaborsAndPartsState.reusablePriceLoading() = LaborsAndPartsReusablePartPriceLoadingState;
  const factory LaborsAndPartsState.reusablePriceSuccess() = LaborsAndPartsReusablePartPriceSuccessState;
  const factory LaborsAndPartsState.submitLoading() = LaborsAndPartssubmitLoadingState;
  const factory LaborsAndPartsState.submitEditPartMarkSuccess() = LaborsAndPartsSubmitEditPartMarkState;
  const factory LaborsAndPartsState.submitAddPartMarkSuccess() = LaborsAndPartsSubmitAddPartMarkSuccessState;

}