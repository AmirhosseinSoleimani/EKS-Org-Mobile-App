import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_request_entity.dart';

class LastEvaluationRequestModel extends LastEvaluationRequestEntity {
  LastEvaluationRequestModel({
    super.serviceRequestId,
    super.serviceType,
    super.emdadgarId,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ServiceRequestId'] = serviceRequestId;
    map['serviceType'] = serviceType;
    map['EmdadgarId'] = emdadgarId;
    return map;
  }
}
