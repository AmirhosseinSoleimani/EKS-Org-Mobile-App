import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/home_service_package_request_entity.dart';

class HomeServicePackageRequestModel extends HomeServicePackageRequestEntity {
  HomeServicePackageRequestModel({
    super.carModelGuid,
    super.carModelId,
    super.kilometer,
    super.serviceCategoryId,
    super.serviceType,
    super.nationalCode,
    super.serviceName,
    super.chassisNumber,
    super.cityId,
    super.hasSubscription,
    super.latitude,
    super.longitude,
    super.serviceId,
    super.planningId,
    super.mobileNumber,
    super.serviceRequestId,
  });

  Map<String, dynamic> toJson() => {
    'serviceType': serviceType,
    'serviceCategoryId': serviceCategoryId,
    'kilometer': kilometer,
    'carModelId': carModelId,
    'carInfoGuid': carModelGuid,
    'nationalCode': nationalCode,
    'serviceName': serviceName,
    'Latitude': latitude,
    'Longitude': longitude,
    'ChassisNumber': chassisNumber,
    'ServiceId': serviceId,
    'CityId': cityId,
    'hasSubscription': hasSubscription,
    'MobileNumber': mobileNumber,
    'planningId': planningId,
    'serviceRequestId': serviceRequestId,
  };
}
