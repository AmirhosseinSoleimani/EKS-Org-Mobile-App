
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/last_evaluation_param_entity.dart';

class LastEvaluationParamModel extends LastEvaluationParamEntity {
  const LastEvaluationParamModel({
    super.serviceRequestId,
    super.emdadgarId,
    super.serviceType,
  });

  factory LastEvaluationParamModel.fromJson(Map<String, dynamic> json) {
    return LastEvaluationParamModel(
      serviceRequestId: json['serviceRequestId'],
      emdadgarId: json['emdadgarId'],
      serviceType: ServiceType.fromValue(json['serviceType']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceRequestId': serviceRequestId,
      'emdadgarId': emdadgarId,
      'serviceType': serviceType?.value,
    };
  }
}