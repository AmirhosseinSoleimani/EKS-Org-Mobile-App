
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/insert_home_service_service_request_model.dart';

class InsertHomeServiceServiceRequestEntity {
  final int? serviceType;
  final int? serviceCategoryId;
  final int? serviceRequestId;
  final int? kilometer;
  final int? carModelId;
  final String? carInfoGuid;
  final String? chassisNumber;

  const InsertHomeServiceServiceRequestEntity({
    this.serviceType,
    this.serviceCategoryId,
    this.kilometer,
    this.carModelId,
    this.carInfoGuid,
    this.serviceRequestId,
    this.chassisNumber,
  });

  InsertHomeServiceServiceRequestModel toModel() {
    return InsertHomeServiceServiceRequestModel(
      serviceType: serviceType,
      serviceCategoryId: serviceCategoryId,
      kilometer: kilometer,
      carModelId: carModelId,
      carInfoGuid: carInfoGuid,
      serviceRequestId: serviceRequestId,
      chassisNumber: chassisNumber,
    );
  }
}
