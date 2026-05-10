import 'package:eks_sana_plus_org/src/features/services/data/models/reference_car_model.dart';

class ReferenceCarEntity {
  final int? id;
  final int? ownerUserId;
  final int? carModelId;
  final String? name;
  final int? productionYear;
  final String? licensePlateNo;
  final String? chassisNo;
  final int? color;
  final String? engineNumber;
  final bool? isDeleted;
  final bool? isDirty;
  final bool? selected;

  const ReferenceCarEntity({
    this.id,
    this.ownerUserId,
    this.carModelId,
    this.name,
    this.productionYear,
    this.licensePlateNo,
    this.chassisNo,
    this.color,
    this.engineNumber,
    this.isDeleted,
    this.isDirty,
    this.selected,
  });

  ReferenceCarEntity copyWith({
    int? id,
    int? ownerUserId,
    int? carModelId,
    String? name,
    int? productionYear,
    String? licensePlateNo,
    String? chassisNo,
    int? color,
    String? engineNumber,
    bool? isDeleted,
    bool? isDirty,
    bool? selected,
  }) {
    return ReferenceCarEntity(
      id: id ?? this.id,
      ownerUserId: ownerUserId ?? this.ownerUserId,
      carModelId: carModelId ?? this.carModelId,
      name: name ?? this.name,
      productionYear: productionYear ?? this.productionYear,
      licensePlateNo: licensePlateNo ?? this.licensePlateNo,
      chassisNo: chassisNo ?? this.chassisNo,
      color: color ?? this.color,
      engineNumber: engineNumber ?? this.engineNumber,
      isDeleted: isDeleted ?? this.isDeleted,
      isDirty: isDirty ?? this.isDirty,
      selected: selected ?? this.selected,
    );
  }

  ReferenceCarModel toModel() {
    return ReferenceCarModel(
      id: id,
      carModelId: carModelId,
      ownerUserId: ownerUserId,
      name: name,
      productionYear: productionYear,
      licensePlateNo: licensePlateNo,
      chassisNo: chassisNo,
      color: color,
      engineNumber: engineNumber,
      isDeleted: isDeleted,
      isDirty: isDirty,
      selected: selected,
    );
  }
}
