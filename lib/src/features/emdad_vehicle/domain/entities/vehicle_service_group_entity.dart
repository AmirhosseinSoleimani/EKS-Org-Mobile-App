import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/vehicle_service_group_model.dart';

class VehicleServiceCategoryEntity {
  final int? id;
  final String? title;
  final int? serviceTypeId;
  final String? serviceTypeTitle;
  final bool? selected;

  const VehicleServiceCategoryEntity({
    this.id,
    this.title,
    this.serviceTypeId,
    this.serviceTypeTitle,
    this.selected,
  });

  VehicleServiceCategoryModel toModel() {
    return VehicleServiceCategoryModel(
      id: id,
      title: title,
      serviceTypeId: serviceTypeId,
      serviceTypeTitle: serviceTypeTitle,
      selected: selected,
    );
  }

  VehicleServiceCategoryEntity copyWith({
    int? id,
    String? title,
    int? serviceTypeId,
    String? serviceTypeTitle,
    bool? selected,
  }) {
    return VehicleServiceCategoryEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      serviceTypeId: serviceTypeId ?? this.serviceTypeId,
      serviceTypeTitle: serviceTypeTitle ?? this.serviceTypeTitle,
      selected: selected ?? this.selected,
    );
  }
}

class VehicleServiceGroupEntity {
  final List<VehicleServiceCategoryEntity>? emdadCategories;
  final int? serviceType;
  final String? serviceTypeTitle;

  const VehicleServiceGroupEntity({
    this.emdadCategories,
    this.serviceType,
    this.serviceTypeTitle,
  });

  VehicleServiceGroupModel toModel() {
    return VehicleServiceGroupModel(
      emdadCategories: emdadCategories
          ?.map((item) => item.toModel())
          .toList(),
      serviceType: serviceType,
      serviceTypeTitle: serviceTypeTitle,
    );
  }

  VehicleServiceGroupEntity copyWith({
    List<VehicleServiceCategoryEntity>? emdadCategories,
    int? serviceType,
    String? serviceTypeTitle,
  }) {
    return VehicleServiceGroupEntity(
      emdadCategories: emdadCategories ?? this.emdadCategories,
      serviceType: serviceType ?? this.serviceType,
      serviceTypeTitle: serviceTypeTitle ?? this.serviceTypeTitle,
    );
  }
}
