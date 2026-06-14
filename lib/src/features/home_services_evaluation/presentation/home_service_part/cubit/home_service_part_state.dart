import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_service_part_state.freezed.dart';

@freezed
class HomeServicePartState with _$HomeServicePartState {

  const factory HomeServicePartState.idle() = _Idle;
  const factory HomeServicePartState.loading() = _Loading;
  const factory HomeServicePartState.success() = _Success;
  const factory HomeServicePartState.error({required DialogDataModel dialogDataModel}) = _Error;
  const factory HomeServicePartState.notice({required DialogDataModel dialogDataModel}) = _Notice;
  const factory HomeServicePartState.partPriceLoading() = _PartPriceLoading;
  const factory HomeServicePartState.partPriceSuccess() = _PartPriceSuccess;
  const factory HomeServicePartState.reusablePriceLoading() = _ReusablePriceLoading;
  const factory HomeServicePartState.reusablePriceSuccess() = _ReusablePriceSuccess;
  const factory HomeServicePartState.submitLoading() = _SubmitLoading;
  const factory HomeServicePartState.submitEditPartMarkSuccess() = _SubmitEditPartMarkSuccess;
  const factory HomeServicePartState.submitAddPartMarkSuccess() = _SubmitAddPartMarkSuccess;

}