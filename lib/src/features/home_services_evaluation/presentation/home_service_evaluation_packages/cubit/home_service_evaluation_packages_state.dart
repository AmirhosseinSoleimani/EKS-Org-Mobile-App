
import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_service_evaluation_packages_state.freezed.dart';

@freezed
class HomeServiceEvaluationPackagesState with _$HomeServiceEvaluationPackagesState {

  const factory HomeServiceEvaluationPackagesState.idle() = HomeServiceEvaluationPackagesIdleState;
  const factory HomeServiceEvaluationPackagesState.error({required DialogDataModel dialogDataModel}) = HomeServiceEvaluationPackagesErrorState;
  const factory HomeServiceEvaluationPackagesState.notice({required DialogDataModel dialogDataModel}) = HomeServiceEvaluationPackagesNoticeState;

  const factory HomeServiceEvaluationPackagesState.success() = HomeServiceEvaluationPackagesSuccessState;
  const factory HomeServiceEvaluationPackagesState.loading() = HomeServiceEvaluationPackagesLoadingState;

  const factory HomeServiceEvaluationPackagesState.servicesLoading({required int id}) = HomeServiceEvaluationPackagesServicesLoadingState;
  const factory HomeServiceEvaluationPackagesState.servicesSuccess({required int id}) = HomeServiceEvaluationPackagesServicesSuccessState;

  const factory HomeServiceEvaluationPackagesState.servicePackageLoading() = HomeServiceEvaluationPackagesServicePackageLoadingState;
  const factory HomeServiceEvaluationPackagesState.servicePackageSuccess() = HomeServiceEvaluationPackagesServicePackageSuccessState;

  const factory HomeServiceEvaluationPackagesState.validateServicesLoading() = HomeServiceEvaluationPackagesValidateServicesLoadingState;
  const factory HomeServiceEvaluationPackagesState.validateServicesSuccess() = HomeServiceEvaluationPackagesValidateServicesSuccessState;
}