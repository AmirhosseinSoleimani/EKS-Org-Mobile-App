class VehicleModelFilterParamEntity {
  const VehicleModelFilterParamEntity({
    this.skip = 0,
    this.pageSize = 10,
    this.code,
    this.name,
    this.isActive,
    this.navganTypeTitle,
    this.hasDepot,
  });

  final int skip;
  final int pageSize;
  final String? code;
  final String? name;
  final bool? isActive;
  final String? navganTypeTitle;
  final bool? hasDepot;
}
