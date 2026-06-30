import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/distance_to_customer_request_entity.dart';

class DistanceToCustomerRequestModel extends DistanceToCustomerRequestEntity {
  DistanceToCustomerRequestModel({
    super.needHaml,
    super.serviceRequestId,
    required super.serviceType,
    super.needCustomerDistance,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['needHaml'] = needHaml;
    map['ServiceRequestId'] = serviceRequestId;
    map['serviceType'] = serviceType.value;
    map['needCustomerDistance'] = needCustomerDistance;
    return map;
  }
}
