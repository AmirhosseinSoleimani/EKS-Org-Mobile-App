import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/vehicle_service_group_entity.dart';

class VehicleServiceCategoryModel extends VehicleServiceCategoryEntity {
  const VehicleServiceCategoryModel({
    super.id,
    super.title,
    super.serviceTypeId,
    super.serviceTypeTitle,
    super.selected,
  });

  factory VehicleServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    return VehicleServiceCategoryModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      serviceTypeId: json['serviceTypeId'] as int?,
      serviceTypeTitle: json['serviceTypeTitle'] as String?,
      selected: json['selected'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'serviceTypeId': serviceTypeId,
      'serviceTypeTitle': serviceTypeTitle,
      'selected': selected,
    };
  }
}

class VehicleServiceGroupModel extends VehicleServiceGroupEntity {
  const VehicleServiceGroupModel({
    super.emdadCategories,
    super.serviceType,
    super.serviceTypeTitle,
  });

  factory VehicleServiceGroupModel.fromJson(Map<String, dynamic> json) {
    return VehicleServiceGroupModel(
      emdadCategories: (json['emdadCategories'] as List<dynamic>?)
          ?.map(
            (item) => VehicleServiceCategoryModel.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList(),
      serviceType: json['serviceType'] as int?,
      serviceTypeTitle: json['serviceTypeTitle'] as String?,
    );
  }

  static List<VehicleServiceGroupModel> fromJsonList(List<dynamic> json) {
    return json
        .map(
          (item) => VehicleServiceGroupModel.fromJson(
            Map<String, dynamic>.from(item as Map),
          ),
        )
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'emdadCategories': emdadCategories
          ?.map((item) => item.toModel().toJson())
          .toList(),
      'serviceType': serviceType,
      'serviceTypeTitle': serviceTypeTitle,
    };
  }
}
