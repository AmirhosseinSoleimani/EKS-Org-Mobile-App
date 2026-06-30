import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/distance_to_customer_request_model.dart';

class DistanceToCustomerRequestEntity {
  int? serviceRequestId;
  bool? needHaml;
  ServiceType serviceType;
  bool? needCustomerDistance;

  DistanceToCustomerRequestEntity({
    required this.serviceType,
    this.serviceRequestId,
    this.needHaml,
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
