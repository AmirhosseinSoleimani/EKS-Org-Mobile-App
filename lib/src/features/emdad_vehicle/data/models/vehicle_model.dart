import 'package:eks_sana_plus_org/src/features/emdad_vehicle/domain/entities/vehicle_model_entity.dart';

class VehicleModelModel extends VehicleModelEntity {
  const VehicleModelModel({
    super.id,
    super.name,
    super.code,
    super.navganTypeId,
    super.navganTypeTitle,
    super.navganTypeCode,
    super.title,
    super.isActive,
    super.isDeleted,
    super.insertUserFullName,
    super.updateUserFullName,
    super.insertDateTime,
    super.insertDateTimeJalali,
    super.hasDepot,
  });

  factory VehicleModelModel.fromJson(Map<String, dynamic> json) {
    return VehicleModelModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      navganTypeId: json['navganTypeId'] as int?,
      navganTypeTitle: json['navganTypeTitle'] as String?,
      navganTypeCode: json['navganTypeCode'] as String?,
      title: json['title'] as String?,
      isActive: json['isActive'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      insertUserFullName: json['insertUserFullName'] as String?,
      updateUserFullName: json['updateUserFullName'] as String?,
      insertDateTime: json['insertDateTime'] as String?,
      insertDateTimeJalali: json['insertDateTimeJalali'] as String?,
      hasDepot: json['hasDepot'] as bool?,
    );
  }

  static List<VehicleModelModel> fromJsonList(List<dynamic> json) {
    return json
        .map(
          (item) => VehicleModelModel.fromJson(
            Map<String, dynamic>.from(item as Map),
          ),
        )
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'navganTypeId': navganTypeId,
      'navganTypeTitle': navganTypeTitle,
      'navganTypeCode': navganTypeCode,
      'title': title,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'insertUserFullName': insertUserFullName,
      'updateUserFullName': updateUserFullName,
      'insertDateTime': insertDateTime,
      'insertDateTimeJalali': insertDateTimeJalali,
      'hasDepot': hasDepot,
    };
  }
}
