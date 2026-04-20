import 'package:eks_sana_plus_org/src/features/services/domain/entities/params/evaluation_history_param_entity.dart';

class EvaluationHistoryParamModel extends EvaluationHistoryParamEntity {
  const EvaluationHistoryParamModel({
    super.serviceRequestId,
    super.serviceType,
  });

  factory EvaluationHistoryParamModel.fromJson(Map<String, dynamic> json) {
    return EvaluationHistoryParamModel(
      serviceRequestId: json['serviceRequestId'],
      serviceType: json['serviceType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "serviceRequestId": serviceRequestId,
      "serviceType": serviceType,
    };
  }
}
