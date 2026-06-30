import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/accept_evaluation_param_model.dart';

class AcceptEvaluationParamEntity {
  final String? emdadgarEvaluationId;
  final ServiceType serviceType;
  final int? serviceRequestId;

  const AcceptEvaluationParamEntity({
    required this.serviceType,
    this.emdadgarEvaluationId,
    this.serviceRequestId,
  });

  AcceptEvaluationParamModel toModel() {
    return AcceptEvaluationParamModel(
      serviceType: serviceType,
      emdadgarEvaluationId: emdadgarEvaluationId,
      serviceRequestId: serviceRequestId,
    );
  }
}
