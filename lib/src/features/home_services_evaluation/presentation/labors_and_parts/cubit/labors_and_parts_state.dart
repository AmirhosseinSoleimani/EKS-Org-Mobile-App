import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'labors_and_parts_state.freezed.dart';

@freezed
class LaborsAndPartsState with _$LaborsAndPartsState {

  const factory LaborsAndPartsState.idle() = LaborsAndPartsIdleState;
  const factory LaborsAndPartsState.loading() = LaborsAndPartsLoadingState;
  const factory LaborsAndPartsState.success() = LaborsAndPartsSuccessState;
  const factory LaborsAndPartsState.error({ required BottomSheetMessageModel message,}) = LaborsAndPartsErrorState;
  const factory LaborsAndPartsState.notice({ required BottomSheetMessageModel message,}) = LaborsAndPartsNoticeState;
  const factory LaborsAndPartsState.partPriceLoading() = LaborsAndPartsPartPriceLoadingState;
  const factory LaborsAndPartsState.laborLoading() = LaborsAndPartsLaborLoadingState;
  const factory LaborsAndPartsState.partLoading() = LaborsAndPartsPartLoadingState;
  const factory LaborsAndPartsState.markLoading() = LaborsAndPartsMarkLoadingState;
  const factory LaborsAndPartsState.partPriceSuccess() = LaborsAndPartsPartPriceSuccessState;
  const factory LaborsAndPartsState.reusablePriceLoading() = LaborsAndPartsReusablePartPriceLoadingState;
  const factory LaborsAndPartsState.reusablePriceSuccess() = LaborsAndPartsReusablePartPriceSuccessState;
  const factory LaborsAndPartsState.submitLoading() = LaborsAndPartssubmitLoadingState;
  const factory LaborsAndPartsState.submitEditPartMarkSuccess() = LaborsAndPartsSubmitEditPartMarkState;
  const factory LaborsAndPartsState.submitAddPartMarkSuccess() = LaborsAndPartsSubmitAddPartMarkSuccessState;

}