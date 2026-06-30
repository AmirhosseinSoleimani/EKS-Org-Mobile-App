import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';

class ServiceCategoryRequestModel {
  final ServiceType serviceType;

  const ServiceCategoryRequestModel({
    required this.serviceType,
  });

  factory ServiceCategoryRequestModel.fromJson(Map<String, dynamic> json) {
    return ServiceCategoryRequestModel(
      serviceType: ServiceType.fromValue(json['ServiceType'] as int?),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ServiceType': serviceType.value,
    };
  }
}