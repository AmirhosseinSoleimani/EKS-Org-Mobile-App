

import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'service_list_state.freezed.dart';

@freezed
class ServiceListState with _$ServiceListState {

  const factory ServiceListState.idle() = ServiceListStateIdleState;
  const factory ServiceListState.loading() = ServiceListStateLoadingState;
  const factory ServiceListState.success() = ServiceListStateSuccessState;
  const factory ServiceListState.error({required DialogDataModel dialogDataModel}) = ServiceListStateErrorState;
  const factory ServiceListState.getServiceLoading() = ServiceListStateGetServiceLoadingState;
  const factory ServiceListState.getServiceSuccess() = ServiceListStateGetServiceSuccessState;
  const factory ServiceListState.selectServiceLoading() = ServiceListStateSelectServiceLoadingState;
  const factory ServiceListState.selectServiceSuccess() = ServiceListStateSelectServiceSuccessState;
}