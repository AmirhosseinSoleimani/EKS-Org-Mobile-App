
import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_service_evaluation_packages_state.freezed.dart';

@freezed
class HomeServiceEvaluationPackagesState
    with _$HomeServiceEvaluationPackagesState {

  const factory HomeServiceEvaluationPackagesState.idle() =
  HomeServiceEvaluationPackagesIdleState;

  const factory HomeServiceEvaluationPackagesState.loading() =
  HomeServiceEvaluationPackagesLoadingState;

  const factory HomeServiceEvaluationPackagesState.success() =
  HomeServiceEvaluationPackagesSuccessState;

  const factory HomeServiceEvaluationPackagesState.error({
    required String message,
  }) = HomeServiceEvaluationPackagesErrorState;

  const factory HomeServiceEvaluationPackagesState.notice({
    required String message,
  }) = HomeServiceEvaluationPackagesNoticeState;

  const factory HomeServiceEvaluationPackagesState.servicesLoading({
    required int id,
  }) = HomeServiceEvaluationPackagesServicesLoadingState;

  const factory HomeServiceEvaluationPackagesState.servicesSuccess({
    required int id,
  }) = HomeServiceEvaluationPackagesServicesSuccessState;

  const factory HomeServiceEvaluationPackagesState.servicePackageLoading() =
  HomeServiceEvaluationPackagesServicePackageLoadingState;

  const factory HomeServiceEvaluationPackagesState.servicePackageSuccess() =
  HomeServiceEvaluationPackagesServicePackageSuccessState;

  const factory HomeServiceEvaluationPackagesState.validateServicesLoading() =
  HomeServiceEvaluationPackagesValidateServicesLoadingState;

  const factory HomeServiceEvaluationPackagesState.validateServicesSuccess() =
  HomeServiceEvaluationPackagesValidateServicesSuccessState;
}