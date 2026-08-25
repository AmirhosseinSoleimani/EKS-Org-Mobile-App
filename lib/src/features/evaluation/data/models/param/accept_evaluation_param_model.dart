import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/accept_evaluation_param_entity.dart';

class AcceptEvaluationParamModel extends AcceptEvaluationParamEntity {
  const AcceptEvaluationParamModel({
    required super.serviceType,
    super.emdadgarEvaluationId,
    super.serviceRequestId,
  });

  Map<String,dynamic> toJson() => {
    if (serviceRequestId != null) 'serviceRequestId': serviceRequestId,
    if (emdadgarEvaluationId != null)
      'emdadgarEvaluationId': emdadgarEvaluationId,
    'serviceType': serviceType.value,
  };
}
