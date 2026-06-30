import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/last_evaluation_request_model.dart';

class LastEvaluationRequestEntity {
  final int? serviceRequestId;
  final ServiceType serviceType;
  final int? emdadgarId;

  LastEvaluationRequestEntity({
    required this.serviceType,
    this.serviceRequestId,
    this.emdadgarId,
  });

  LastEvaluationRequestModel toModel() {
    return LastEvaluationRequestModel(
      serviceRequestId: serviceRequestId,
      serviceType: serviceType,
      emdadgarId: emdadgarId,
    );
  }
}
