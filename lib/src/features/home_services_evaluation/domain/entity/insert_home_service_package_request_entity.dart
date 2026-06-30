
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/insert_home_service_package_request_model.dart';

class InsertHomeServicePackageRequestEntity {
  final int? serviceType;
  final String? serviceName;
  final int? serviceCategoryId;
  final String? nationalCode;
  final int? kilometer;
  final int? carModelId;
  final String? carModelGuid;
  final double? latitude;
  final double? longitude;
  final String? chassisNumber;
  final int? cityId;
  final bool? hasSubscription;
  final int? serviceId;
  final int? planningId;
  final String? mobileNumber;
  final int? serviceRequestId;

  const InsertHomeServicePackageRequestEntity({
    this.serviceType,
    this.serviceCategoryId,
    this.kilometer,
    this.carModelId,
    this.carModelGuid,
    this.nationalCode,
    this.serviceName,
    this.longitude,
    this.latitude,
    this.cityId,
    this.hasSubscription,
    this.chassisNumber,
    this.serviceId,
    this.planningId,
    this.mobileNumber,
    this.serviceRequestId,
  });

  InsertHomeServicePackageRequestModel toModel() {
    return InsertHomeServicePackageRequestModel(
      serviceType: serviceType,
      serviceCategoryId: serviceCategoryId,
      kilometer: kilometer,
      carModelId: carModelId,
      carModelGuid: carModelGuid,
      serviceName: serviceName,
      nationalCode: nationalCode,
      chassisNumber: chassisNumber,
      hasSubscription: hasSubscription,
      cityId: cityId,
      longitude: longitude,
      latitude: latitude,
      serviceId: serviceId,
      planningId: planningId,
      mobileNumber: mobileNumber,
      serviceRequestId: serviceRequestId,
    );
  }

}
