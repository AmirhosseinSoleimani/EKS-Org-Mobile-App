import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/features/evaluation/data/models/param/home_service_package_param_model.dart';


class HomeServicePackageParamEntity {
  final int? kilometer;
  final int? serviceCategoryId;
  final ServiceType serviceType;
  final int? serviceId;
  final int? serviceRequestId;

  const HomeServicePackageParamEntity({
    this.kilometer,
    this.serviceCategoryId,
    required this.serviceType,
    this.serviceId,
    this.serviceRequestId,
  });

  HomeServicePackageParamModel toModel() {
    return HomeServicePackageParamModel(
      kilometer: kilometer,
      serviceCategoryId: serviceCategoryId,
      serviceType: serviceType,
      serviceId: serviceId,
      serviceRequestId: serviceRequestId,
    );
  }

  HomeServicePackageParamEntity copyWith({
    int? kilometer,
    int? serviceCategoryId,
    ServiceType? serviceType,
    int? serviceId,
    int? serviceRequestId,
  }) {
    return HomeServicePackageParamEntity(
      kilometer: kilometer ?? this.kilometer,
      serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
      serviceType: serviceType ?? this.serviceType,
      serviceId: serviceId ?? this.serviceId,
      serviceRequestId: serviceRequestId ?? this.serviceRequestId,
    );
  }
}