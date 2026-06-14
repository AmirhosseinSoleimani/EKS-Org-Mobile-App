import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/service_detail_and_check_subscription_request_model.dart';

class ServiceDetailAndCheckSubscriptionRequestEntity {
  int? emdadgarServiceCategoryId;
  int? serviceRequestId;
  int? emdadgarDefectInfoId;
  int? emdadgarEvaluationKilometer;
  int? serviceType;

  ServiceDetailAndCheckSubscriptionRequestEntity({
    this.emdadgarServiceCategoryId,
    this.serviceRequestId,
    this.emdadgarDefectInfoId,
    this.emdadgarEvaluationKilometer,
    this.serviceType,
  });

  ServiceDetailAndCheckSubscriptionRequestEntity copyWith({
    int? emdadgarServiceCategoryId,
    int? serviceRequestId,
    int? emdadgarDefectInfoId,
    int? emdadgarEvaluationKilometer,
    int? serviceType,
  }) {
    return ServiceDetailAndCheckSubscriptionRequestEntity(
      emdadgarServiceCategoryId:
          emdadgarServiceCategoryId ?? this.emdadgarServiceCategoryId,
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      emdadgarDefectInfoId: emdadgarDefectInfoId ?? this.emdadgarDefectInfoId,
      emdadgarEvaluationKilometer:
          emdadgarEvaluationKilometer ?? this.emdadgarEvaluationKilometer,
      serviceType: serviceType ?? this.serviceType,
    );
  }

  ServiceDetailAndCheckSubscriptionRequestModel toModel() {
    return ServiceDetailAndCheckSubscriptionRequestModel(
      emdadgarServiceCategoryId: emdadgarServiceCategoryId,
      serviceRequestId: serviceRequestId,
      emdadgarDefectInfoId: emdadgarDefectInfoId,
      emdadgarEvaluationKilometer: emdadgarEvaluationKilometer,
      serviceType: serviceType,
    );
  }
}
