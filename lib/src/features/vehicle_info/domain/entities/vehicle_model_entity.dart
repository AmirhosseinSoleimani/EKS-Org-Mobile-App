class VehicleModelEntity {
  const VehicleModelEntity({
    required this.id,
    this.name,
    this.code,
    this.navganTypeId,
    this.navganTypeTitle,
    this.navganTypeCode,
    this.isActive,
    this.hasDepot,
    this.type,
  });

  final int id;
  final String? name;
  final String? code;
  final int? navganTypeId;
  final String? navganTypeTitle;
  final String? navganTypeCode;
  final bool? isActive;
  final bool? hasDepot;
  final String? type;

  String get title {
    return name?.trim().isNotEmpty == true ? name!.trim() : '---';
  }
}
