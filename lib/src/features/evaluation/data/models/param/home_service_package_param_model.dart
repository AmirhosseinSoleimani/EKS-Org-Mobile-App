import 'package:eks_sana_plus_org/src/features/evaluation/domain/entities/param/home_service_package_param_entity.dart';

class HomeServicePackageParamModel extends HomeServicePackageParamEntity {
  const HomeServicePackageParamModel({
    super.kilometer,
    super.serviceCategoryId,
    required super.serviceType,
    super.serviceId,
    super.serviceRequestId,
  });

  Map<String, dynamic> toJson() {
    return {
      'kilometer': kilometer,
      'serviceCategoryId': serviceCategoryId,
      'serviceType': serviceType.value,
      'serviceId': serviceId,
      'serviceRequestId': serviceRequestId,
    };
  }
}
