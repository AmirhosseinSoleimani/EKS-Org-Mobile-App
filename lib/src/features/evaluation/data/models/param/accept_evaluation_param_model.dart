import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/accept_evaluation_param_entity.dart';

class AcceptEvaluationParamModel extends AcceptEvaluationParamEntity {
  const AcceptEvaluationParamModel({
    required super.serviceType,
    super.emdadgarEvaluationId,
    super.serviceRequestId,
  });

  Map<String,dynamic> toJson() => {
    'serviceRequestId': serviceRequestId,
    'emdadgarEvaluationId': emdadgarEvaluationId,
    'serviceType': serviceType.value,
  };
}
