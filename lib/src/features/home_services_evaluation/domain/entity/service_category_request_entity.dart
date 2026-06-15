import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/data/model/service_category_request_model.dart';

class ServiceCategoryRequestEntity {
  final ServiceType serviceType;

  const ServiceCategoryRequestEntity({
    required this.serviceType,
  });

  ServiceCategoryRequestEntity copyWith({
    ServiceType? serviceType,
  }) {
    return ServiceCategoryRequestEntity(
      serviceType: serviceType ?? this.serviceType,
    );
  }

  ServiceCategoryRequestModel toModel() {
    return ServiceCategoryRequestModel(
      serviceType: serviceType,
    );
  }
}