import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/accept_evaluation_param_model.dart';

class AcceptEvaluationParamEntity {
  final int? emdadgarEvaluationId;
  final ServiceType serviceType;

  const AcceptEvaluationParamEntity({
    required this.serviceType,
    this.emdadgarEvaluationId,
  });

  AcceptEvaluationParamModel toModel() {
    return AcceptEvaluationParamModel(
      serviceType: serviceType,
      emdadgarEvaluationId: emdadgarEvaluationId,
    );
  }
}
