import 'package:eks_sana_plus_org/src/features/vehicle_model/domain/entities/emdad_service_category_entity.dart';

class VehicleServiceGroupEntity {
  const VehicleServiceGroupEntity({
    this.emdadCategories = const [],
    this.serviceType,
    this.serviceTypeTitle,
  });

  final List<EmdadServiceCategoryEntity> emdadCategories;
  final int? serviceType;
  final String? serviceTypeTitle;

  VehicleServiceGroupEntity copyWith({
    List<EmdadServiceCategoryEntity>? emdadCategories,
  }) {
    return VehicleServiceGroupEntity(
      emdadCategories: emdadCategories ?? this.emdadCategories,
      serviceType: serviceType,
      serviceTypeTitle: serviceTypeTitle,
    );
  }
}
