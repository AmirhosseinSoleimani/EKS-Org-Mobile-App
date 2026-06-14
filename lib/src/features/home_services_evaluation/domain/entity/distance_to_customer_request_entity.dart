import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/distance_to_customer_request_model.dart';

class DistanceToCustomerRequestEntity {
  int? serviceRequestId;
  bool? needHaml;
  int? serviceType;
  bool? needCustomerDistance;

  DistanceToCustomerRequestEntity({
    this.serviceRequestId,
    this.needHaml,
    this.serviceType,
    this.needCustomerDistance,
  });

  DistanceToCustomerRequestModel toModel() {
    return DistanceToCustomerRequestModel(
      needHaml: needHaml,
      serviceRequestId: serviceRequestId,
      serviceType: serviceType,
      needCustomerDistance: needCustomerDistance,
    );
  }
}
