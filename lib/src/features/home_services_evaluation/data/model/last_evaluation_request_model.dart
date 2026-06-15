import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_request_entity.dart';

class LastEvaluationRequestModel extends LastEvaluationRequestEntity {
  LastEvaluationRequestModel({
    required super.serviceType,
    super.serviceRequestId,
    super.emdadgarId,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ServiceRequestId'] = serviceRequestId;
    map['serviceType'] = serviceType.value;
    map['EmdadgarId'] = emdadgarId;
    return map;
  }
}
