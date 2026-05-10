import 'package:eks_sana_plus_org/src/features/services/domain/entities/reference_car_entity.dart';

class ReferenceCarModel extends ReferenceCarEntity {
  const ReferenceCarModel({
    super.id,
    super.ownerUserId,
    super.carModelId,
    super.name,
    super.productionYear,
    super.licensePlateNo,
    super.chassisNo,
    super.color,
    super.engineNumber,
    super.isDeleted,
    super.isDirty,
    super.selected,
  });

  factory ReferenceCarModel.fromJson(Map<String, dynamic> json) {
    return ReferenceCarModel(
      id: json['id'],
      ownerUserId: json['ownerUserId'],
      carModelId: json['carModelId'],
      name: json['name'],
      productionYear: json['productionYear'],
      licensePlateNo: json['licensePlateNo'],
      chassisNo: json['chassisNo'],
      color: json['color'],
      engineNumber: json['engineNumber'],
      isDeleted: json['isDeleted'],
      isDirty: json['isDirty'],
      selected: json['selected'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "ownerUserId": ownerUserId,
      "carModelId": carModelId,
      "name": name,
      "productionYear": productionYear,
      "licensePlateNo": licensePlateNo,
      "chassisNo": chassisNo,
      "color": color,
      "engineNumber": engineNumber,
      "isDeleted": isDeleted,
      "isDirty": isDirty,
      "selected": selected,
    };
  }
}
