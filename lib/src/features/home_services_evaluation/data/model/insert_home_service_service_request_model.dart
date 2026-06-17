import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/insert_home_service_service_request_entity.dart';

class InsertHomeServiceServiceRequestModel
    extends InsertHomeServiceServiceRequestEntity {
  InsertHomeServiceServiceRequestModel({
    super.carInfoGuid,
    super.carModelId,
    super.kilometer,
    super.serviceCategoryId,
    super.serviceType,
    super.serviceRequestId,
    super.chassisNumber,
  });

  Map<String, dynamic> toJson() => {
    'serviceType': serviceType,
    'serviceCategoryId': serviceCategoryId,
    'kilometer': kilometer,
    'carModelId': carModelId,
    'carInfoGuid': carInfoGuid,
    'serviceRequestId': serviceRequestId,
    'chassisNumber': chassisNumber,
  };
}
