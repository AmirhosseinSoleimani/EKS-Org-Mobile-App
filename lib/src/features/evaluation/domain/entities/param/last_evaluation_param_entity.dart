import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/last_evaluation_param_model.dart';

class LastEvaluationParamEntity {
  final int? serviceRequestId;
  final int? emdadgarId;
  final ServiceType? serviceType;

  const LastEvaluationParamEntity({
    this.serviceRequestId,
    this.emdadgarId,
    this.serviceType,
  });

  LastEvaluationParamEntity copyWith({
    int? serviceRequestId,
    int? emdadgarId,
    ServiceType? serviceType,
  }) {
    return LastEvaluationParamEntity(
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      emdadgarId: emdadgarId ?? this.emdadgarId,
      serviceType: serviceType ?? this.serviceType,
    );
  }

  LastEvaluationParamModel toModel() {
    return LastEvaluationParamModel(
      serviceRequestId: serviceRequestId,
      emdadgarId: emdadgarId,
      serviceType: serviceType,
    );
  }
}
