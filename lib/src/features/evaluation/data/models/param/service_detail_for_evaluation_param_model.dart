import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/service_detail_for_evaluation_param_entity.dart';

class ServiceDetailForEvaluationParamModel
    extends ServiceDetailForEvaluationParamEntity {
  const ServiceDetailForEvaluationParamModel({
    required super.serviceType,
    super.aidServiceRequestId,
    super.emdadgarDefectInfoId,
    super.emdadgarServiceCategoryId,
    super.evaluationCustomerKilometer,
    super.serviceRequestId,
  });

  factory ServiceDetailForEvaluationParamModel.fromEntity(
    ServiceDetailForEvaluationParamEntity entity,
  ) {
    return ServiceDetailForEvaluationParamModel(
      aidServiceRequestId: entity.aidServiceRequestId,
      emdadgarDefectInfoId: entity.emdadgarDefectInfoId,
      emdadgarServiceCategoryId: entity.emdadgarServiceCategoryId,
      evaluationCustomerKilometer: entity.evaluationCustomerKilometer,
      serviceRequestId: entity.serviceRequestId,
      serviceType: entity.serviceType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "aidServiceRequestId": aidServiceRequestId,
      "emdadgarDefectInfoId": emdadgarDefectInfoId,
      "emdadgarServiceCategoryId": emdadgarServiceCategoryId,
      "evaluationCustomerKilometer": evaluationCustomerKilometer,
      "serviceRequestId": serviceRequestId,
      "serviceType": serviceType.value,
    };
  }
}
