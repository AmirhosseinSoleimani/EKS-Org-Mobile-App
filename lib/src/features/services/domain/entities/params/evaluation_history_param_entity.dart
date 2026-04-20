import 'package:eks_sana_plus_org/src/features/services/data/models/params/evaluation_history_param_model.dart';

class EvaluationHistoryParamEntity {
  final int? serviceRequestId;
  final int? serviceType;

  const EvaluationHistoryParamEntity({
    this.serviceRequestId,
    this.serviceType,
  });

  EvaluationHistoryParamEntity copyWith({
    int? serviceRequestId,
    int? serviceType,
  }) {
    return EvaluationHistoryParamEntity(
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
      serviceType: serviceType ?? this.serviceType,
    );
  }

  EvaluationHistoryParamModel toModel() {
    return EvaluationHistoryParamModel(
      serviceRequestId: serviceRequestId,
      serviceType: serviceType,
    );
  }
}
