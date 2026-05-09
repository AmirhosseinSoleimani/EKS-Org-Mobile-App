import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/accept_evaluation_param_entity.dart';

class AcceptEvaluationParamModel extends AcceptEvaluationParamEntity {
  const AcceptEvaluationParamModel({
    required super.serviceType,
    super.emdadgarEvaluationId,
  });

  Map<String,dynamic> toJson() => {
    'ServiceType': serviceType,
    'emdadgarEvaluationId': emdadgarEvaluationId,
    'serviceType': serviceType.value,
  };
}
