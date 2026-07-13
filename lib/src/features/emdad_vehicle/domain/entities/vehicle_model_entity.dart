import 'package:eks_sana_plus_org/src/features/emdad_vehicle/data/models/vehicle_model.dart';

class VehicleModelEntity {
  final int? id;
  final String? name;
  final String? code;
  final int? navganTypeId;
  final String? navganTypeTitle;
  final String? navganTypeCode;
  final String? title;
  final bool? isActive;
  final bool? isDeleted;
  final String? insertUserFullName;
  final String? updateUserFullName;
  final String? insertDateTime;
  final String? insertDateTimeJalali;
  final bool? hasDepot;

  const VehicleModelEntity({
    this.id,
    this.name,
    this.code,
    this.navganTypeId,
    this.navganTypeTitle,
    this.navganTypeCode,
    this.title,
    this.isActive,
    this.isDeleted,
    this.insertUserFullName,
    this.updateUserFullName,
    this.insertDateTime,
    this.insertDateTimeJalali,
    this.hasDepot,
  });

  VehicleModelModel toModel() {
    return VehicleModelModel(
      id: id,
      name: name,
      code: code,
      navganTypeId: navganTypeId,
      navganTypeTitle: navganTypeTitle,
      navganTypeCode: navganTypeCode,
      title: title,
      isActive: isActive,
      isDeleted: isDeleted,
      insertUserFullName: insertUserFullName,
      updateUserFullName: updateUserFullName,
      insertDateTime: insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali,
      hasDepot: hasDepot,
    );
  }

  VehicleModelEntity copyWith({
    int? id,
    String? name,
    String? code,
    int? navganTypeId,
    String? navganTypeTitle,
    String? navganTypeCode,
    String? title,
    bool? isActive,
    bool? isDeleted,
    String? insertUserFullName,
    String? updateUserFullName,
    String? insertDateTime,
    String? insertDateTimeJalali,
    bool? hasDepot,
  }) {
    return VehicleModelEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      navganTypeId: navganTypeId ?? this.navganTypeId,
      navganTypeTitle: navganTypeTitle ?? this.navganTypeTitle,
      navganTypeCode: navganTypeCode ?? this.navganTypeCode,
      title: title ?? this.title,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      insertUserFullName: insertUserFullName ?? this.insertUserFullName,
      updateUserFullName: updateUserFullName ?? this.updateUserFullName,
      insertDateTime: insertDateTime ?? this.insertDateTime,
      insertDateTimeJalali: insertDateTimeJalali ?? this.insertDateTimeJalali,
      hasDepot: hasDepot ?? this.hasDepot,
    );
  }
}
