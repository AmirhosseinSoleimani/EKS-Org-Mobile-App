import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/service_detail_for_evaluation_param_model.dart';

class ServiceDetailForEvaluationParamEntity {
  final int? aidServiceRequestId;
  final int? emdadgarDefectInfoId;
  final int? emdadgarServiceCategoryId;
  final int? evaluationCustomerKilometer;
  final int? serviceRequestId;
  final ServiceType serviceType;

  const ServiceDetailForEvaluationParamEntity({
    required this.serviceType,
    this.aidServiceRequestId,
    this.emdadgarDefectInfoId,
    this.emdadgarServiceCategoryId,
    this.evaluationCustomerKilometer,
    this.serviceRequestId,
  });

  ServiceDetailForEvaluationParamEntity copyWith({
    int? aidServiceRequestId,
    int? emdadgarDefectInfoId,
    int? emdadgarServiceCategoryId,
    int? evaluationCustomerKilometer,
    int? serviceRequestId,
    ServiceType? serviceType,
  }) {
    return ServiceDetailForEvaluationParamEntity(
      aidServiceRequestId: aidServiceRequestId ?? this.aidServiceRequestId,
      emdadgarDefectInfoId: emdadgarDefectInfoId ?? this.emdadgarDefectInfoId,
      emdadgarServiceCategoryId:
          emdadgarServiceCategoryId ?? this.emdadgarServiceCategoryId,
      evaluationCustomerKilometer:
          evaluationCustomerKilometer ?? this.evaluationCustomerKilometer,
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      serviceType: serviceType ?? this.serviceType,
    );
  }

  ServiceDetailForEvaluationParamModel toModel() =>
      ServiceDetailForEvaluationParamModel.fromEntity(this);
}
