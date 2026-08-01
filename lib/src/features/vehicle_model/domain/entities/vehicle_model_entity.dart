class VehicleModelEntity {
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
}
